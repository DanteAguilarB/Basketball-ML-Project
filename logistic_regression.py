import torch
import pandas as pd


# ── Helpers ───────────────────────────────────────────────────────────────────

def sigmoid(z):
    return 1 / (1 + torch.exp(-z))


def binary_cross_entropy(q, y):
    q = q.clamp(1e-7, 1 - 1e-7)
    return -(y * torch.log(q) + (1 - y) * torch.log(1 - q)).mean()


def rbf_kernel_features(X, num_kernels=3):
    """
    Apply RBF kernel expansion to each feature column independently.
    For each feature, place `num_kernels` Gaussian bumps evenly spaced
    between its min and max, then concatenate all expanded columns.

    Input:  X of shape (n_samples, n_features)
    Output: Phi of shape (n_samples, n_features * num_kernels)
    """
    expanded = []
    for j in range(X.shape[1]):
        col = X[:, j]
        centers = torch.linspace(col.min(), col.max(), num_kernels)
        bandwidth = (col.max() - col.min()) / num_kernels + 1e-8
        for k in range(num_kernels):
            expanded.append(torch.exp(-0.5 * ((col - centers[k]) / bandwidth) ** 2))
    return torch.stack(expanded, dim=1)


# ── Data preparation ──────────────────────────────────────────────────────────

def clean_df(df):
    return df[df['Player'] == 'Totals'].reset_index(drop=True)


def prepare_features(df, num_kernels=3):
    feature_cols = [
        'REB', 'PF', 'A', 'TO', 'BLK', 'STL',
        'PTS', 'ORB', 'DRB', 'FG_pct', '3PT_pct', 'FT_pct'
    ]
    target_col = ['Won']

    df[feature_cols] = df[feature_cols].apply(pd.to_numeric, errors='coerce').fillna(0)

    train_ix = df.sample(frac=0.8, random_state=42).index
    test_ix  = df.drop(train_ix).index

    X_train_raw = torch.tensor(df.loc[train_ix, feature_cols].values, dtype=torch.float32)
    X_test_raw  = torch.tensor(df.loc[test_ix,  feature_cols].values, dtype=torch.float32)

    # Normalize using train stats only
    mean = X_train_raw.mean(dim=0)
    std  = X_train_raw.std(dim=0) + 1e-8
    X_train_norm = (X_train_raw - mean) / std
    X_test_norm  = (X_test_raw  - mean) / std

    # RBF kernel expansion — centers computed on train set only
    X_train_phi = rbf_kernel_features(X_train_norm, num_kernels)
    X_test_phi  = rbf_kernel_features(X_test_norm,  num_kernels)

    # Prepend intercept column
    X_train = torch.cat([torch.ones(X_train_phi.shape[0], 1), X_train_phi], dim=1)
    X_test  = torch.cat([torch.ones(X_test_phi.shape[0],  1), X_test_phi],  dim=1)

    y_train = torch.tensor(df.loc[train_ix, target_col].values, dtype=torch.float32)
    y_test  = torch.tensor(df.loc[test_ix,  target_col].values, dtype=torch.float32)

    return X_train, y_train, X_test, y_test


# ── Model ─────────────────────────────────────────────────────────────────────

class BinaryLogisticRegression:
    def __init__(self, n_features):
        self.w = torch.zeros(n_features, 1)

    def forward(self, X):
        return sigmoid(X @ self.w)


# ── Optimizer ─────────────────────────────────────────────────────────────────

class GradientDescentOptimizer:
    def __init__(self, model, lr=0.1):
        self.model = model
        self.lr = lr

    def grad_func(self, X, y):
        q = self.model.forward(X)
        n = y.shape[0]
        return (1 / n) * X.T @ (q - y)

    def step(self, X, y):
        self.model.w -= self.lr * self.grad_func(X, y)


# ── Evaluation helpers ────────────────────────────────────────────────────────

def confusion_matrix(y_true, y_pred):
    cm = torch.zeros((2, 2), dtype=torch.int32)
    for i in range(2):
        for j in range(2):
            cm[i, j] = ((y_true == i) & (y_pred == j)).sum().item()
    return cm


def roc_curve(y_true, q):
    TPR, FPR = [], []
    for tau_val in torch.linspace(1, 0, 100):
        y_pred = (q > tau_val).float()
        cm = confusion_matrix(y_true, y_pred)
        tpr = cm[1, 1] / (cm[1, 0] + cm[1, 1]) if (cm[1, 0] + cm[1, 1]) > 0 else 0.0
        fpr = cm[0, 1] / (cm[0, 0] + cm[0, 1]) if (cm[0, 0] + cm[0, 1]) > 0 else 0.0
        TPR.append(tpr.item() if hasattr(tpr, 'item') else tpr)
        FPR.append(fpr.item() if hasattr(fpr, 'item') else fpr)
    return FPR, TPR

