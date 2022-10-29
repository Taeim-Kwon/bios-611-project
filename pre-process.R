library(tidyverse)
library(tidyr)
library(dplyr)

# The dataset includes error values "
linkedin_derived <- read_csv("source_data/LinkedIn_Profile_Data.csv") %>% 
  rename(emo_disgust = emp_disgust) %>% distinct()

linkedin_derived %>% write.csv("derived_data/linkedin_derived.csv")