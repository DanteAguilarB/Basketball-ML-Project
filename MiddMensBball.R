

# READ ME -----------------------------------------------------------------

# ================================================================
# Author: Charlie Grossman
# Date Pull Requested: 2026-04-19

# PREFACE: This r file is what I like to call "concepts of a data pipeline" it is not
#   well written, it doesn't do everything I want it to do yet, but it's a start. 
#.  I wrote this in R because it is the language in which I learned how to scrape. 
#   I also enjoy using their extensive library of built ins for manipulating data
#   frames. Most other groups probably have a %100 python workflow, but you get what
#   you get I guess.
#
#THE FINAL VISION: When it is done it will give us a nice tidy long, season long 
#   csv of boxscores and maybe some extra random statistics as well. It WILL NOT
#    deal with the cleaning of play by plays. (That's Dante's domain.) 
#
#CURRENTLY: it contains links to all of the games of the midd-mens-basketball 
#   games from their most recent season. It then proceeds to start parsing JUST ONE
#   of those links (should be as easy as making a function once the formula for one
#.  is down.) It is still  unfinished. That said, it should make the direction the 
#   data pipeline is going in very clear. 
# ================================================================

# LINKS -------------------------------------------------------------------


library(rvest)

#bball_website <- "https://athletics.middlebury.edu/boxscore.aspx?id=15613&path=mbball"

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



#raw <- read_html(bball_website)|> 
#  html_elements("table")

raw <- read_html(bball_website)|> 
  html_table(fill = TRUE)

#creating a separate table for every table on this website
for (i in seq_along(raw)) {
  assign(paste0("table_", i), raw[[i]])
}

point_totals_nov14 <- table_1
rm(table_1) #this table contains the 1st and 2nd half point totals for each team




# boxscore, summary, random -----------------------------------------------

midd_boxscore_nov14 <- table_2
rm(table_2) #BOXSCORE
view(midd_boxscore_nov14)

Cmidd_boxscore_nov14 <- midd_boxscore_nov14

view(Cmidd_boxscore_nov14)


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

rb_cols <- parse_rb(Cmidd_boxscore_nov14$`ORB-DRB`)
Cmidd_boxscore_nov14$ORB <- rb_cols$ORB
Cmidd_boxscore_nov14$DRB <- rb_cols$DRB

Cmidd_boxscore_nov14$FG_pct   <- parse_pct(Cmidd_boxscore_nov14$FG)
Cmidd_boxscore_nov14$`3PT_pct` <- parse_pct(Cmidd_boxscore_nov14$`3PT`)
Cmidd_boxscore_nov14$FT_pct   <- parse_pct(Cmidd_boxscore_nov14$FT)
Cmidd_boxscore_nov14 <- Cmidd_boxscore_nov14[, !names(Cmidd_boxscore_nov14) %in% c("FG", "3PT", "FT", "ORB-DRB")]

Cmidd_boxscore_nov14$GS <- ifelse(Cmidd_boxscore_nov14$Player == "Totals", NA,
                                  ifelse(Cmidd_boxscore_nov14$GS == "*", 1, 0))

midd_sum_nov14 <- table_3
rm(table_3)  
 #1s and 2nd half field goal pct, 3pt pct, ft
#POTENTIALLY MERGE WITH POINT TOTALS (TABLE 1)

midd_random_nov14 <- table_4
rm(table_4)  #a bizarre, very untidy df of random stats

opp_boxscore_nov14 <- table_5
rm(table_5) #BOXSCORE

opp_sum_nov14 <- table_6
rm(table_6)  #1s and 2nd half field goal pct, 3pt pct, ft
#POTENTIALLY MERGE WITH POINT TOTALS (TABLE 1)

opp_random_nov14 <- table_7
rm(table_7)  #a bizarre, very untidy df of random stats


# playByPlays ---------------------------------------------------------------

half1_pbp_nov14 <- table_8
rm(table_8)  #not sure how to clean

half2_pbp_nov14 <-table_9
rm(table_9)  #not sure how to clean



# reallyRandomStats ---------------------------------------------------------------

point_off_turnovers <-table_10
rm(table_10)


second_chance_points <-table_11
rm(table_11)

bench_points <-table_12
rm(table_12)

lead_gained_by <-table_13
rm(table_13)

points_in_the_paint<-table_14
rm(table_14)

fast_break_points<-table_15
rm(table_15)

score_tied_by<-table_16
rm(table_16)
