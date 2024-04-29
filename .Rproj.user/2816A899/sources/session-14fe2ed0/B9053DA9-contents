library(tidyverse)
library(dplyr)
library(ggplot2)

#' Question 3: How likely are the mens and womens teams going to win their game?
#'

# Grabbing necessary data
Win_Loss <- Games %>%
  select(c("Team", "W.L"))

# Changing all Losses to L
Win_Loss[] <- lapply(Win_Loss, function(x)
  {x[grepl("l", tolower(x), fixed = TRUE)] <- "Loss"; x})

# Changing all Wins to W
Win_Loss["W.L"][Win_Loss["W.L"] == "W (OT)"] <- "Win"
Win_Loss["W.L"][Win_Loss["W.L"] == "W (2 OT)"] <- "Win"
Win_Loss["W.L"][Win_Loss["W.L"] == "W"] <- "Win"

# Table
WL <- table(Win_Loss$W.L, Win_Loss$Team)
rownames(WL) <- c("Loss", "Win")
WL <- addmargins(WL)

WL

# Graph
Win_Loss_Counts <- Win_Loss %>%
  count(Team, W.L)

Win_Loss_Counts$Status <- paste(Win_Loss_Counts$Team, Win_Loss_Counts$W.L,
                                sep = " ")

Win_Loss_Counts$ypos <- c(600, 480, 280, 100)

WL_Graph <- ggplot(aes(x = "", y = n, fill = Status), data = Win_Loss_Counts) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  theme_void() +
  theme(legend.position="none") +
  geom_text(aes(y = ypos, label = Status ), color = "white", size=4) +
  scale_fill_manual(breaks = c("Mens Loss", "Mens Win",
                               "Womens Loss", "Womens Win"),
                    values = c("deepskyblue", "navy", "pink", "deeppink"))

WL_Graph
