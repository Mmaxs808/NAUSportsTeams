library(tidyverse)

# Combining the Coaches and Basketball DFs
Players <- read.csv("data/Players.csv")
Games <- read.csv("data/Games.csv")
Coaches <- read.csv("data/Coaches.csv")
Basketball <- read.csv("data/NAUBasketball.csv")

Team_Stats <- Basketball %>%
  left_join(Coaches, by = c("Year" = "Year", "Team" = "Team")) %>%
  select(-c("X.y", "X.x"))

Players <- Players %>%
  rename(
    FG = FG.,
    X3PT = X3PT.,
    FT = FT.,
    ORB = OREB,
    DRB = DREB,
    TRB = REB
  )
