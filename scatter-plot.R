library(tidyverse)

linkedin_derived <- read_csv("derived_data/linkedin_derived.csv")

age_beauty <- ggplot(linkedin_derived, aes(age, beauty)) + geom_point()

ggsave("figures/scatter-plot.png", age_beauty)