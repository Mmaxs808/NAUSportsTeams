library(reshape2)
library(dplyr)
library(tidyverse)

Player_Stats <- melt(Players, id.vars = "Team",
                     measure.vars = 7:16 )

numVars <- n_distinct(Player_Stats$variable)

columnNames <- c("variable", "estimate", "t_stat", "p_value",
                 "intercept_estimate", "intercept_t_stat", "intercept_p_value")

tests <- data.frame(matrix(nrow = 1, ncol = length(columnNames) ) )
colnames(tests) <- columnNames

for(num in 1:numVars)
{
  column <- colnames(Players[num + 6])

  df <- Player_Stats %>%
    filter(variable == column) %>%
    select(-variable)

  model <- lm(value ~ Team, data = df)

  t_stats <- summary(model)$coefficients[,3]
  p_values <-summary(model)$coefficients[,4]

  tests <- rbind(tests, list(column, model$coefficients[2], t_stats[2], p_values[2],
                             model$coefficients[1], t_stats[1], p_values[1]))

  num <- num + 1

}

tests <- tests %>%
  filter(!is.na(variable))

summary(model)
