library(tidyverse)
library(patchwork)

linkedin_derived <- read_csv("derived_data/linkedin_derived.csv")

beauty_bmale <- ggplot(linkedin_derived, aes(beauty, beauty_male)) + geom_point()

beauty_bfemale <- ggplot(linkedin_derived, aes(beauty, beauty_female)) + geom_point()

bmale_bfemale <- ggplot(linkedin_derived, aes(beauty_male, beauty_female)) + geom_point()

png("figures/collinearity_beauty.png")
beauty_bmale + beauty_bfemale + bmale_bfemale + plot_layout(ncol = 2)
dev.off()