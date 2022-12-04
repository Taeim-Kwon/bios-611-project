library(tidyverse)
library(patchwork)

linkedin_derived <- read_csv("derived_data/linkedin_derived.csv")

beauty <- ggplot(linkedin_derived, aes(beauty)) + geom_histogram() + xlab("Beauty")
beauty_male <- ggplot(linkedin_derived, aes(beauty_male)) + geom_histogram() + xlab("Beauty Male")
beauty_feamle <- ggplot(linkedin_derived, aes(beauty_female)) + geom_histogram() + xlab("Beauty Female")

png("figures/beauty_histogram.png")
beauty + beauty_feamle + beauty_male
dev.off()
