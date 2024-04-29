library(tidyverse)
library(dplyr)
library(stringr)
library(ggplot2)

# Grabbing outliers from main data frame
Attendance_Points <- Team_Stats %>%
  select(c("Year", "Team", "Total.Points", "Total"))

# Changing Col. Names
names(Attendance_Points)[names(Attendance_Points) == "Total"] <- "Attendance"
names(Attendance_Points)[names(Attendance_Points) == "Total.Points"] <- "Total_Points"

# Removing 0 attendance (COVID)
Attendance_Points <- Attendance_Points %>%
  filter(Attendance != 0)

AP_Outliers <- Attendance_Points %>%
  filter(Attendance > 14000 | Total_Points > 2500)

attach(AP_Outliers)

AP_Outliers <- AP_Outliers[order(Year), ]

detach(AP_Outliers)

AP_Outliers

# Grabbing the game data
Outlier_Games <- Games %>%
  select(c(X, Team, Opponent, Score)) %>%
  rename(Year = X)

# Points First
# Getting Home or Away
Outlier_Games[c("Home_or_Away", "Location")] <- str_split_fixed(
  Outlier_Games$Opponent, ' ', 2)

Outlier_Games <- subset(Outlier_Games, select = -Opponent)

Outlier_Games$Home_or_Away[Outlier_Games$Home_or_Away == "at"] <- "Away"
Outlier_Games$Home_or_Away[Outlier_Games$Home_or_Away == "vs"] <- "Home"

# Getting Scores by Team
Outlier_Games[c("NAU_Score", "Their_Score")] <- str_split_fixed(
  Outlier_Games$Score, '-', 2)

Outlier_Games <- subset(Outlier_Games, select = -Score)

Outlier_Games <- Outlier_Games %>%
  mutate(across(c(NAU_Score, Their_Score), function(x) as.numeric(x)))

# Making Points Graph
Pts_Outlier <- ggplot(data = Outlier_Games, aes(x = Their_Score, y = NAU_Score)) +
  geom_point(aes(color=Team), shape = 20, alpha = 0.5) +
  scale_color_manual(breaks = c("Mens", "Womens"),
                     values = c("blue", "hotpink")) +
  geom_point(data = Outlier_Games %>%
               filter(Year == 2023),
             size = 3,
             aes(color = Team)) +
  geom_hline(aes(yintercept = mean(NAU_Score)), color = "goldenrod",
             linewidth = 1) +
  labs(title = "Points Scored Per Game by Team",
       x = "Opponent Score",
       y = "NAU Score") +
  theme(legend.position = c(0.85, 0.15),
        plot.title = element_text(hjust = 0.5, face = "bold"),
        legend.background = element_rect(fill = "transparent"),
        legend.key = element_rect(fill = "transparent"),
        panel.background = element_rect(fill= "lightblue", color = "black",
                                        linewidth = 2),
        panel.grid.major = element_line(color = "gray10", linewidth = 0.25),
        panel.grid.minor = element_line(color = "gray50", linewidth = 0.25))

Pts_Outlier

# Grabbing games with us over 100 pts
Over100 <- Outlier_Games %>%
  filter(NAU_Score >= 100)

Over100

tiff("docs/Points_Outlier_Graph_Updated.png")
{
  library(tidyverse)
  library(dplyr)
  library(stringr)
  library(ggplot2)

  # Grabbing outliers from main data frame
  Attendance_Points <- Team_Stats %>%
    select(c("Year", "Team", "Total.Points", "Total"))

  # Changing Col. Names
  names(Attendance_Points)[names(Attendance_Points) == "Total"] <- "Attendance"
  names(Attendance_Points)[names(Attendance_Points) == "Total.Points"] <- "Total_Points"

  # Removing 0 attendance (COVID)
  Attendance_Points <- Attendance_Points %>%
    filter(Attendance != 0)

  AP_Outliers <- Attendance_Points %>%
    filter(Attendance > 14000 | Total_Points > 2500)

  attach(AP_Outliers)

  AP_Outliers <- AP_Outliers[order(Year), ]

  detach(AP_Outliers)

  AP_Outliers

  # Grabbing the game data
  Outlier_Games <- Games %>%
    select(c(X, Team, Opponent, Score)) %>%
    rename(Year = X)

  # Points First
  # Getting Home or Away
  Outlier_Games[c("Home_or_Away", "Location")] <- str_split_fixed(
    Outlier_Games$Opponent, ' ', 2)

  Outlier_Games <- subset(Outlier_Games, select = -Opponent)

  Outlier_Games$Home_or_Away[Outlier_Games$Home_or_Away == "at"] <- "Away"
  Outlier_Games$Home_or_Away[Outlier_Games$Home_or_Away == "vs"] <- "Home"

  # Getting Scores by Team
  Outlier_Games[c("NAU_Score", "Their_Score")] <- str_split_fixed(
    Outlier_Games$Score, '-', 2)

  Outlier_Games <- subset(Outlier_Games, select = -Score)

  Outlier_Games <- Outlier_Games %>%
    mutate(across(c(NAU_Score, Their_Score), function(x) as.numeric(x)))

  # Making Points Graph
  ggplot(data = Outlier_Games, aes(x = Their_Score, y = NAU_Score)) +
    geom_point(aes(color=Team), shape = 20, alpha = 0.5) +
    scale_color_manual(breaks = c("Mens", "Womens"),
                       values = c("blue", "hotpink")) +
    geom_point(data = Outlier_Games %>%
                 filter(Year == 2023),
               size = 3,
               aes(color = Team)) +
    geom_hline(aes(yintercept = mean(NAU_Score)), color = "goldenrod",
               linewidth = 1) +
    labs(title = "Points Scored Per Game by Team",
         x = "Opponent Score",
         y = "NAU Score") +
    theme(legend.position = c(0.85, 0.15),
          plot.title = element_text(hjust = 0.5, face = "bold"),
          legend.background = element_rect(fill = "transparent"),
          legend.key = element_rect(fill = "transparent"),
          panel.background = element_rect(fill= "lightblue", color = "black",
                                          linewidth = 2),
          panel.grid.major = element_line(color = "gray10", linewidth = 0.25),
          panel.grid.minor = element_line(color = "gray50", linewidth = 0.25) )
}
dev.off()

