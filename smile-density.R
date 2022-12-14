library(tidyverse)

linkedin_derived <- read_csv("derived_data/linkedin_derived.csv") %>% select(-1)

smile <- ggplot(linkedin_derived, aes(smile)) + geom_density()

ggsave("figures/smile-density.png", smile)