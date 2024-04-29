library(tidyverse)
library(dplyr)
library(ggplot2)
library(reshape2)

#' Question 2: Which team, on average, has the better players?
#' t-test
#' boxplots

# Separating Data
Mens_Players <- Players %>%
  filter(Team == "Mens") %>%
  select(FG:PTS)
Womens_Players <- Players %>%
  filter(Team == "Womens") %>%
  select(FG:PTS)

# Making Average Dataframes
# Mens
columns <- colnames(Mens_Players)
means <- colMeans(Mens_Players)

Mens_Average <- data.frame(
  Columns = columns,
  Mens = means
                )

# Womens
columns <- colnames(Womens_Players)
means <- colMeans(Womens_Players)

Womens_Average <- data.frame(
  Columns = columns,
  Womens = means
)


# Combining
Players_Averages <- melt(merge(Mens_Average, Womens_Average, by = "Columns"))
names(Players_Averages)[names(Players_Averages) == "variable"] <- "Team"
names(Players_Averages)[names(Players_Averages) == "value"] <- "Average"

# Graph
PAvg <- ggplot(data=Players_Averages, aes(x = reorder(Columns, -Average), y = Average)) +
  geom_bar(aes(fill = Team), stat = "identity", position = "dodge") +
  scale_fill_manual(values = c("blue", "hotpink")) +
  scale_y_sqrt() +
  labs(title = "Players Averages",
       x = "Columns") +
  theme(legend.position = c(0.9, 0.75),
        plot.title = element_text(hjust = 0.5, face = "bold"),
        legend.background = element_rect(fill = "transparent"),
        legend.key = element_rect(fill = "transparent"),
        panel.background = element_rect(fill= "lightblue", color = "black",
                                        linewidth = 2),
        panel.grid.major = element_line(color = "gray10", linewidth = 0.25),
        panel.grid.minor = element_line(color = "gray50", linewidth = 0.25) )

#PAvg

# Boxplot
# Getting necessary data
Player_Stats <- melt(Players, id.vars = "Team",
                     measure.vars = 7:16 )

# Graph
tiff("docs/PAGraph.png")
{
  library(ggplot2)
  library(reshape2)

  Player_Stats <- melt(Players, id.vars = "Team",
                       measure.vars = 7:16 )

  ggplot(data=Player_Stats) +
    geom_boxplot(aes(x = reorder(variable, -value), y = value, color = Team),
                 linewidth = 1, fatten = 0.75) +
    scale_color_manual(values = c("blue", "hotpink")) +
    scale_y_sqrt() +
    labs(title = "Players Statistics",
         x = "Columns") +
    theme(legend.position = c(0.9, 0.75),
          plot.title = element_text(hjust = 0.5, face = "bold"),
          legend.title = element_text(face = "bold"),
          legend.background = element_rect(fill = "transparent"),
          legend.key = element_rect(fill = "transparent"),
          panel.background = element_rect(fill= "lightblue", color = "black",
                                          linewidth = 2),
          panel.grid.major = element_line(color = "gray10", linewidth = 0.25),
          panel.grid.minor = element_line(color = "gray50", linewidth = 0.25) )
}
dev.off()

Box <- ggplot(data=Player_Stats) +
  geom_boxplot(aes(x = reorder(variable, -value), y = value, color = Team),
               linewidth = 1, fatten = 0.75) +
  scale_color_manual(values = c("blue", "hotpink")) +
  scale_y_sqrt() +
  labs(title = "Players Statistics",
       x = "Columns") +
  theme(legend.position = c(0.9, 0.75),
        plot.title = element_text(hjust = 0.5, face = "bold"),
        legend.title = element_text(face = "bold"),
        legend.background = element_rect(fill = "transparent"),
        legend.key = element_rect(fill = "transparent"),
        panel.background = element_rect(fill= "lightblue", color = "black",
                                        linewidth = 2),
        panel.grid.major = element_line(color = "gray10", linewidth = 0.25),
        panel.grid.minor = element_line(color = "gray50", linewidth = 0.25))

Box
