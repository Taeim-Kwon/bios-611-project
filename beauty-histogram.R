library(tidyverse)

linkedin_derived <- read_csv("derived_data/linkedin_derived.csv")

beauty <- ggplot(linkedin_derived, aes(beauty)) + geom_histogram()

ggsave("figures/beauty_histogram.png", beauty)