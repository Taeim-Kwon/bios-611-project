library(tidyverse)
emotion_gender <- read_csv("derived_data/linkedin_derived.csv") %>% select(-1)

emotion_gender <- emotion_gender %>% 
  group_by(m_urn_id) %>% 
  filter(row_number() == n()) %>%
  select(c(m_urn_id, no_of_previous_positions, beauty, beauty_female, beauty_male, gender, emo_anger:emo_surprise))

emotion_gender$male <- ifelse(emotion_gender$gender=="Male", 1, 0)

# remove outliers
emotion_gender <- subset(emotion_gender, emo_anger <= 100 & 0 <= emo_anger)
emotion_gender <- subset(emotion_gender, emo_disgust <= 100 & 0 <= emo_disgust)
emotion_gender <- subset(emotion_gender, emo_fear <= 100 & 0 <= emo_fear)
emotion_gender <- subset(emotion_gender, emo_happiness <= 100 & 0 <= emo_happiness)
emotion_gender <- subset(emotion_gender, emo_neutral <= 100 & 0 <= emo_neutral)
emotion_gender <- subset(emotion_gender, emo_sadness <= 100 & 0 <= emo_sadness)
emotion_gender <- subset(emotion_gender, emo_surprise <= 100 & 0 <= emo_surprise)

emotion_gender %>% write.csv("derived_data/emotion_gender.csv")