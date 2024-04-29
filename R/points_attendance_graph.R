library(tidyverse)
library(dplyr)
library(ggplot2)

#' Question 1: Do the players score more points based on the attendance
#' at the game?
#'

# Grabbing necessary data
Attendance_Points <- Team_Stats %>%
  select(c("Year", "Team", "Total.Points", "Total"))

# Changing Col. Names
names(Attendance_Points)[names(Attendance_Points) == "Total"] <- "Attendance"
names(Attendance_Points)[names(Attendance_Points) == "Total.Points"] <- "Total_Points"

# Removing 0 attendance (COVID)
Attendance_Points <- Attendance_Points %>%
  filter(Attendance != 0)

# Getting means for each team
Mens <- Attendance_Points %>%
  filter(Team == "Mens")
Womens <- Attendance_Points %>%
  filter(Team == "Womens")

# Graph
AP <- ggplot(data = Attendance_Points, aes(x=Total_Points, y=Attendance)) +
  geom_point(aes(color=Team), size=3) +
  scale_color_manual(breaks = c("Mens", "Womens"),
                     values = c("blue", "hotpink")) +
  geom_point(data = Attendance_Points %>%
               filter(Attendance > 14000 | Total_Points > 2500),
             pch = 21,
             size = 7,
             stroke = 2,
             color = "purple") +
  labs(x = "Total Points",
       title = "Season Points vs Season Attendance") +
  geom_hline(yintercept = mean(Mens$Attendance), color = "blue",
             linetype = "dashed") +
  geom_hline(yintercept = mean(Womens$Attendance), color = "hotpink",
             linetype = "dashed") +
  geom_vline(xintercept = mean(Mens$Total_Points), color = "blue",
             linetype = "dashed") +
  geom_vline(xintercept = mean(Womens$Total_Points), color = "hotpink",
             linetype = "dashed") +
  theme(legend.position = c(0.75, 0.75))

AP

# Plotting Just Points Graph
Points_Graph <- ggplot(data = Attendance_Points, aes(x = Year, y = Total_Points)) +
  geom_line(aes(color = Team), linewidth = 1) +
  geom_point(aes(color = Team), size = 2.5) +
  scale_color_manual(breaks = c("Mens", "Womens"),
                     values = c("blue", "hotpink")) +
  labs(y = "Total Points",
       title = "Season Points for each Year") +
  geom_hline(yintercept = mean(Mens$Total_Points), color = "blue",
             linetype = "dashed", linewidth = 0.75) +
  geom_hline(yintercept = mean(Womens$Total_Points), color = "hotpink",
             linetype = "dashed", linewidth = 0.75) +
  geom_vline(xintercept = 2020, color = "blue",
             linetype = "dashed", linewidth = 0.75) +
  annotate("text", x = 2019.5, y = 2410, label = "New Coach", angle = 90) +
  theme(legend.position = c(0.9, 0.2),
        plot.title = element_text(hjust = 0.5, face = "bold"),
        legend.title = element_text(face = "bold"),
        legend.background = element_rect(fill = "transparent"),
        legend.key = element_rect(fill = "transparent"),
        panel.background = element_rect(fill= "lightblue", color = "black",
                                        linewidth = 2),
        panel.grid.major = element_line(color = "gray10", linewidth = 0.25),
        panel.grid.minor = element_line(color = "gray50", linewidth = 0.25))

Points_Graph


tiff("docs/PvAGraph.png")
{
  library(tidyverse)
  library(dplyr)
  library(ggplot2)

  #' Question 1: Do the players score more points based on the attendance
  #' at the game?
  #'

  # Grabbing necessary data
  Attendance_Points <- Team_Stats %>%
    select(c("Year", "Team", "Total.Points", "Total"))

  # Changing Col. Names
  names(Attendance_Points)[names(Attendance_Points) == "Total"] <- "Attendance"
  names(Attendance_Points)[names(Attendance_Points) == "Total.Points"] <- "Total_Points"

  # Removing 0 attendance (COVID)
  Attendance_Points <- Attendance_Points %>%
    filter(Attendance != 0)

  # Getting means for each team
  Mens <- Attendance_Points %>%
    filter(Team == "Mens")
  Womens <- Attendance_Points %>%
    filter(Team == "Womens")

  # Graph
  ggplot(data = Attendance_Points, aes(x = Year, y = Total_Points)) +
    geom_line(aes(color = Team), linewidth = 1) +
    geom_point(aes(color = Team), size = 2.5) +
    scale_color_manual(breaks = c("Mens", "Womens"),
                       values = c("blue", "hotpink")) +
    labs(y = "Total Points",
         title = "Season Points for each Year") +
    geom_hline(yintercept = mean(Mens$Total_Points), color = "blue",
               linetype = "dashed", linewidth = 0.75) +
    geom_hline(yintercept = mean(Womens$Total_Points), color = "hotpink",
               linetype = "dashed", linewidth = 0.75) +
    geom_vline(xintercept = 2020, color = "blue",
               linetype = "dashed", linewidth = 0.75) +
    annotate("text", x = 2019.5, y = 2410, label = "New Coach", angle = 90) +
    theme(legend.position = c(0.9, 0.2),
          plot.title = element_text(hjust = 0.5, face = "bold"),
          legend.title = element_text(face = "bold"),
          legend.background = element_rect(fill = "transparent"),
          legend.key = element_rect(fill = "transparent"),
          panel.background = element_rect(fill= "lightblue", color = "black",
                                          linewidth = 2),
          panel.grid.major = element_line(color = "gray10", linewidth = 0.25),
          panel.grid.minor = element_line(color = "gray50", linewidth = 0.25))
}
dev.off()
