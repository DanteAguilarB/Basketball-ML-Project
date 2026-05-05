
# READ ME -----------------------------------------------------------------

# ================================================================
# Author: Charlie Grossman
# Date Pull Requested: 2026-05-02

# GENERAL: This file takes many irregularly named urls corresponding to Middlebury Men's
# Basketball data. It then proceeds to, using some helping functions, clean up some
# ugly looking columns(FG cols in 9-10 form to .90, etc.), add some new columns
# (date, Winner, Team) which are needed for looking at these entries in one big df. 

# KNOWN ISSUES: There appear to be six bad links: 13, 35, 37, 57, 67, and 74. Iwent to go poke
# around and see if they could be easily fixed, but the irregular naming conventions makes it
# tedious, annoying, and probably not worth the time that could be spent working on models and such. 
# ================================================================

library(rvest)


# LINKS AND PUTTING THEM INTO VECTOR --------------------------------------

#2025-2026 Season, starting in November going through February
bball_website1 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15637&path=mbball"
bball_website2 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15636&path=mbball"
bball_website3 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15635&path=mbball"
bball_website4 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15634&path=mbball"
bball_website5 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15633&path=mbball"
bball_website6 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15632&path=mbball"
bball_website7 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15631&path=mbball"
bball_website8 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15630&path=mbball"
bball_website9 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15629&path=mbball"
bball_website10 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15628&path=mbball"
bball_website11 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15627&path=mbball"
bball_website12 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15626&path=mbball"
bball_website13 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15625&path=mbball"
bball_website14 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15624&path=mbball"
bball_website15 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15623&path=mbball"
bball_website16 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15622&path=mbball"
bball_website17 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15621&path=mbball"
bball_website18 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15620&path=mbball"
bball_website19 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15619&path=mbball"
bball_website20 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15618&path=mbball"
bball_website21 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15617&path=mbball"
bball_website22 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15616&path=mbball"
bball_website23 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15615&path=mbball"
bball_website24 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15614&path=mbball"
bball_website25 <- "https://athletics.middlebury.edu/boxscore.aspx?id=15613&path=mbball"

#2024-2025 Season, starting in November going through February
bball_website26 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14793&path=mbball"
bball_website27 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14794&path=mbball"
bball_website28 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14795&path=mbball"
bball_website29 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14796&path=mbball"
bball_website30 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14797&path=mbball"
bball_website31 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14798&path=mbball"
bball_website32 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14799&path=mbball"
bball_website33 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14800&path=mbball"
bball_website34 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14801&path=mbball"
bball_website35 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14802&path=mbball"
bball_website36 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14803&path=mbball"
bball_website37 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14804&path=mbball"
bball_website38 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14805&path=mbball"
bball_website39 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14806&path=mbball"
bball_website40 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14807&path=mbball"
bball_website41 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14808&path=mbball"
bball_website42 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14809&path=mbball"
bball_website43 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14810&path=mbball"
bball_website44 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14811&path=mbball"
bball_website45 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14812&path=mbball"
bball_website46 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14813&path=mbball"
bball_website47 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14814&path=mbball"
bball_website48 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14815&path=mbball"
bball_website49 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14816&path=mbball"
bball_website50 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14817&path=mbball"
bball_website51 <- "https://athletics.middlebury.edu/boxscore.aspx?id=14818&path=mbball"

#2023-2024 season, starting in November going through February
bball_website52 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13240&path=mbball"
bball_website53 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13242&path=mbball"
bball_website54 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13243&path=mbball"
bball_website55 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13244&path=mbball"
bball_website56 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13286&path=mbball"
bball_website57 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13287&path=mbball"
bball_website58 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13270&path=mbball"
bball_website59 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13271&path=mbball"
bball_website60 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13272&path=mbball"
bball_website61 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13273&path=mbball"
bball_website62 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13274&path=mbball"
bball_website63 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13275&path=mbball"
bball_website64 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13276&path=mbball"
bball_website65 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13277&path=mbball"
bball_website66 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13278&path=mbball"
bball_website67 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13279&path=mbball"
bball_website68 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13280&path=mbball"
bball_website69 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13281&path=mbball"
bball_website70 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13282&path=mbball"
bball_website71 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13283&path=mbball"
bball_website72 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13284&path=mbball"
bball_website73 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13285&path=mbball"
bball_website74 <- "https://athletics.middlebury.edu/boxscore.aspx?id=13683&path=mbball"

#2022-2023 season, starting in November going through February
bball_website75 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12439&path=mbball"
bball_website76 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12440&path=mbball"
bball_website77 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12441&path=mbball"
bball_website78 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12442&path=mbball"
bball_website79 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12443&path=mbball"
bball_website80 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12444&path=mbball"
bball_website81 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12445&path=mbball"
bball_website82 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12446&path=mbball"
bball_website83 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12447&path=mbball"
bball_website84 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12448&path=mbball"
bball_website85 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12449&path=mbball"
bball_website86 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12450&path=mbball"
bball_website87 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12451&path=mbball"
bball_website88 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12452&path=mbball"
bball_website89 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12453&path=mbball"
bball_website90 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12454&path=mbball"
bball_website91 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12455&path=mbball"
bball_website92 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12456&path=mbball"
bball_website93 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12458&path=mbball"
bball_website94 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12459&path=mbball"
bball_website95 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12461&path=mbball"
bball_website96 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12463&path=mbball"
bball_website97 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12465&path=mbball"
bball_website98 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12911&path=mbball"
bball_website99 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12929&path=mbball"
bball_website100 <- "https://athletics.middlebury.edu/boxscore.aspx?id=12931&path=mbball"

# Collect all URLs into a vector
bball_urls <- c(
  bball_website1, bball_website2, bball_website3, bball_website4, bball_website5,
  bball_website6, bball_website7, bball_website8, bball_website9, bball_website10,
  bball_website11, bball_website12, bball_website13, bball_website14, bball_website15,
  bball_website16, bball_website17, bball_website18, bball_website19, bball_website20,
  bball_website21, bball_website22, bball_website23, bball_website24, bball_website25,
  bball_website26, bball_website27, bball_website28, bball_website29, bball_website30,
  bball_website31, bball_website32, bball_website33, bball_website34, bball_website35,
  bball_website36, bball_website37, bball_website38, bball_website39, bball_website40,
  bball_website41, bball_website42, bball_website43, bball_website44, bball_website45,
  bball_website46, bball_website47, bball_website48, bball_website49, bball_website50,
  bball_website51, bball_website52, bball_website53, bball_website54, bball_website55,
  bball_website56, bball_website57, bball_website58, bball_website59, bball_website60,
  bball_website61, bball_website62, bball_website63, bball_website64, bball_website65,
  bball_website66, bball_website67, bball_website68, bball_website69, bball_website70,
  bball_website71, bball_website72, bball_website73, bball_website74, bball_website75,
  bball_website76, bball_website77, bball_website78, bball_website79, bball_website80,
  bball_website81, bball_website82, bball_website83, bball_website84, bball_website85,
  bball_website86, bball_website87, bball_website88, bball_website89, bball_website90,
  bball_website91, bball_website92, bball_website93, bball_website94, bball_website95,
  bball_website96, bball_website97, bball_website98, bball_website99, bball_website100
)

# FUINCTIONS  --------------------------------------------------------------
parse_pct <- function(x) {
  parts <- strsplit(as.character(x), "-")
  sapply(parts, function(p) {
    made <- as.integer(p[1])
    att  <- as.integer(p[2])
    ifelse(att == 0, NA, made / att)
  })
}

parse_rb <- function(x) {
  parts <- strsplit(as.character(x), "-")
  result <- sapply(parts, function(p) c(as.integer(p[1]), as.integer(p[2])))
  data.frame(ORB = result[1, ], DRB = result[2, ])
}

clean_boxscore <- function(df) {
  rb_cols <- parse_rb(df$`ORB-DRB`)
  df$ORB <- rb_cols$ORB
  df$DRB <- rb_cols$DRB
  df$FG_pct <- parse_pct(df$FG)
  df$`3PT_pct` <- parse_pct(df$`3PT`)
  df$FT_pct <- parse_pct(df$FT)
  df <- df[, !names(df) %in% c("FG", "3PT", "FT", "ORB-DRB")]
  df$GS <- ifelse(df$Player == "Totals", NA, ifelse(df$GS == "*", 1, 0))
  df <- df |> mutate(MIN = as.numeric(gsub("\\+", "", MIN)))
  return(df)
}

parse_winner <- function(rawWinnerBothCell) {
  top    <- rawWinnerBothCell$Team[1]
  bottom <- rawWinnerBothCell$Team[2]
  winner_str <- ifelse(startsWith(top, "Winner"), top, bottom)
  loser_str  <- ifelse(startsWith(top, "Winner"), bottom, top)
  list(
    WinningTeam = tail(strsplit(winner_str, " ")[[1]], 1),
    LosingTeam  = tail(strsplit(loser_str,  " ")[[1]], 1)
  )
}


# Iteratively Adding All Websites to all_games---------------------------------------------

all_games <- data.frame()

for (i in 1:length(bball_urls)) {
  tryCatch({
  url <- bball_urls[[i]]
  
raw <- read_html(url)|> 
  html_table(fill = TRUE)

rawDate <- read_html(url) |>
  html_element(xpath = '//*[@id="box-score"]/header/div/div[2]/aside/dl/dd[1]') |>
  html_text(trim = TRUE)

result <- parse_winner(raw[[1]])
WinningTeam <- result$WinningTeam
LosingTeam  <- result$LosingTeam

rawMiddBox <- raw[[2]]
cleanMiddBox <- clean_boxscore(rawMiddBox)
cleanMiddBox <- cleanMiddBox |> mutate(Team = "Middlebury")
cleanMiddBox <- cleanMiddBox |> mutate(Date = as.Date(rawDate, format = "%m/%d/%y"))
cleanMiddBox <- cleanMiddBox |> mutate(Won = ifelse(WinningTeam == "Middlebury", 1, 0))
rawOppBox <- raw[[5]]
cleanOppBox <- clean_boxscore(rawOppBox)
cleanOppBox <- cleanOppBox |> mutate(Team = ifelse(WinningTeam == "Middlebury", LosingTeam, WinningTeam))
cleanOppBox <- cleanOppBox |> mutate(Date = as.Date(rawDate, format = "%m/%d/%y"))
cleanOppBox <- cleanOppBox |> mutate(Won = ifelse(WinningTeam != "Middlebury", 1, 0))

cleanBox <- bind_rows(cleanMiddBox, cleanOppBox)
all_games <- bind_rows(all_games, cleanBox)
  }, error = function(e) {
    message("Skipping URL ", i, " (", url, "): ", e$message)
  })
}
write_csv(all_games, "~/Downloads/all_games.csv")
