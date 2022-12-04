library(tidyverse)

# linkedin_derived
linkedin_derived <- read_csv("source_data/LinkedIn_Profile_Data.csv") %>% 
  rename(emo_disgust = emp_disgust) %>% distinct()

linkedin_derived <- linkedin_derived %>% select(-1) %>% unique()

linkedin_derived %>% write.csv("derived_data/linkedin_derived.csv")
