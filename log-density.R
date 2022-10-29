library(tidyverse)

linkedin_derived <- read_csv("derived_data/linkedin_derived.csv")

avg_prev_length <- ggplot(linkedin_derived, aes(log(avg_previous_position_length))) + geom_density()

ggsave("figures/log-density.png", avg_prev_length)