# Basketball-ML-Project

## Group Members
- Aguilar, Dante 
- Grossman, Charlie
- Jin, Hannah

## Abstract 

We will be addressing the problem of better understanding the factors that influence Middlebury Men's Basketball effective field goal percentage. Using both box scores and parsed play by play data, we will construct 2 different models that a) classify the most optimal lineups for effective feild goal percentage b) create a regression model (with lasso regularization) to identify the most influential features in terms of efective field goal percentage. For evaluating the classifier, we will have a randomly grouped lineup baseline. For the regression model we will split the data into training (70%) and testing (30%) and evaluating using visualizations and accuracy. 


## Motivation and Question
We are motivated by the idea that basketball produces rich performance data, but coaches still need to turn that data into decisions. In our case, we want to use performance data from Middlebury, its opponents, and the broader conference to support better game preparation. 

Our main question is:
Can we predict which combination of Middlebury team players are most likely to perform unusually well against opponents, and summarize those predictions in a way that is genuinely useful for self-scouting?

## What You Will Learn
This project is valuable because it sits at the intersection of machine learning, sports strategy, and real-world decision-making. It gives us a chance to work on meaningful prediction problems using data we care about, while also learning how to manage noisy datasets, define useful labels, and evaluate model quality in an applied setting. 

## Ethics
If successful, our project could help coaches and players prepare more effectively by turning historical performance data into more focused self-scouting. It could benefit small programs that want more analytical support but do not have the resources of large Division I teams.

The groups most likely to benefit are coaches, athletes, and analysts who want better game preparation. However, some groups may be excluded from benefit if they do not have access to similar data or technical tools. There is also a risk that players could be reduced to overly narrow statistical summaries, or that model predictions could be trusted too much in situations where the data is limited or noisy.

Whether the world becomes better because of this project depends on at least two assumptions:
1. Past basketball performance contains enough real signal to support useful and fair predictions.
2. Better scouting information helps teams make better decisions without replacing human judgment in an unhealthy way.

Our project is lower-stakes than systems used in policing, hiring, or medicine, but bias and misinterpretation are still relevant. For example, a model trained mostly on one kind of team or data quality level may generalize poorly to others. We will therefore aim to be explicit about uncertainty, limitations, and the difference between a model-supported recommendation and a guaranteed truth.


