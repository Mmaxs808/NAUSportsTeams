library(tidyverse)
library(magick)
library(webshot2)
library(knitr)

#Making the variables table
variables <- data.frame(
  Abbreviation = c("FG", "X3PT", "FT", "ORB", "DRB", "TRB", "AST", "STL", "BLK",
                   "PTS", "W.L", "OFF", "DEF", "TOT", "AVG", "FGM.A", "PCT",
                   "X3FG.A", "FTM.A", "PTS", "PPG", "SM", "FGG", "X3P", "X3A",
                   "FTP", "FTA", "ATT", "PG", "ATR", "POT"),
  DataSet = c(rep("Players", 10), rep("Games", 5), rep("Games and Team Stats", 4),
              rep("Team Stats", 12)),
  Meaning = c("2 Point Shots", "3 Point Shots", "Free Throws",
              "Offensive Rebounds", "Defensive Rebounds", "Total Rebounds",
              "Assists", "Steals", "Blocks", "Points", "Win or Loss",
              "Offensive Rebounds", "Defensive Rebounds", "Total Rebounds",
              "Average Rebounds", "2 Pointers Made to Attempted",
              "2 Pointer Percentage", "3 Pointers Made to Attempted",
              "Free Throws Made to Attempted", "Total Points",
              "Points Per Game", "Scoring Margin", "2 Pointers Per Game",
              "3 Pointer Percentage", "3 Pointers Per Game", "Free Throw Percentage",
              "Free Throws Per Game", "Total Attendance", "Attendance Per Game",
              "Assist Turnover Ratio", "Points Off Turnovers"),
  Description = c("Percentage of 2 Pointers Made Throughout Season",
                  "Percentage of 3 Pointers Made Throughout Season",
                  "Percentage of Free Throws Made Throughout Season",
                  "Average Number of Offensive Rebounds Made per Game",
                  "Average Number of Defensive Rebounds Made per Game",
                  "Average Number of Total Rebounds Made per Game",
                  "Average Number of Assists Made per Game",
                  "Average Number of Steals Made per Game",
                  "Average Number of Blocks Made per Game",
                  "Average Number of Points Made per Game",
                  "Whether NAU Wins or Losses the Game",
                  "Number of Offensive Rebounds Made that Game",
                  "Number of Defensive Rebounds Made that Game",
                  "Number of Total Rebounds Made that Game",
                  "The Running Average of Rebounds Made for Games that Year",
                  "The Number of 2 Pointers Made to the Number that was Attempted",
                  "The Number of 2 Pointers Made / The Number of 2 Pointers",
                  "The Number of 3 Pointers Made to the Number that was Attempted",
                  "The Number of Free Throws Made to the Number that was Attempted",
                  "Total Points Scored that Season",
                  "Average Points per Game",
                  "Difference between NAU Average Points Per Game and Opponents Average Points Per Game",
                  "Average 2 Pointers Made Per Game",
                  "The Number of 3 Pointers Made / The Number of 3 Pointers",
                  "Average 3 Pointers Made Per Game",
                  "The Number of Free Throws Made / The Number of Free Throws",
                  "Average Free Throws Made Per Game",
                  "Total Number of People at Attendance for NAU Games",
                  "Average Attendance at Away Games to Average Attendance at Home Games",
                  "Number of Assists Recorded by Team / Number of Turnovers Committed",
                  "Percentage of Points scored by Team After Forcing Turnover")   )

variables


"
Team Stats
PTS, Total Points, Total Points Scored that Season
PPG, Points Per Game, Average Points per Game
SM, Scoring Margin, Difference between NAU Average Points Per Game and Opponents Average Points Per Game
FGG, 2 Pointers Per Game, Average 2 Pointers Made Per Game
X3P, 3 Pointer Percentage, The Number of 3 Pointers Made / The Number of 3 Pointers
X3A, 3 Pointers Per Game, Average 3 Pointers Made Per Game
FTP, Free Throw Percentage,The Number of Free Throws Made / The Number of Free Throws
FTA, Free Throws Per Game, Average Free Throws Made Per Game
ATT, Total Attendance, Total Number of People at Attendance for NAU Games
PG, Attendance Per Game, Average Attendance at Away Games to Average Attendance at Home Games
ATR, Assist Turnover Ratio, Number of Assists Recorded by Team / Number of Turnovers Committed
POT, Points Off Turnovers, Percentage of Points scored by Team After Forcing Turnover
"



#kable(variables, format="pdf", caption = "Variable Descriptions") %>%
 # kable_styling("striped") %>%
  #save_kable("variables.pdf")
