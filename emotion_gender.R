library(tidyverse)
library(gbm)
library(pROC)
library(glmnet)

set.seed(1234)

emotion_gender <- read_csv("derived_data/emotion_gender.csv") %>% select(-1)

# GBM
f <- formula("male ~ beauty + beauty_female + beauty_male + emo_anger + emo_disgust + emo_fear + emo_happiness + emo_neutral + emo_sadness + emo_surprise")

train <- runif(nrow(emotion_gender)) < 0.75

gbm <- gbm(f, data = emotion_gender %>% dplyr::filter(train))

png("figures/emo_gender_gbm.png")
summary(gbm)
dev.off()

# ROC curve
test <- emotion_gender %>% filter(!train)

test$male_predict <- predict(gbm, newdata = emotion_gender %>% dplyr::filter(!train))

roc <- roc(test$male, test$male_predict)

png("figures/emo_gender_roc.png")
roc_curve <- plot(roc)
dev.off()

summary(roc)
roc$auc

# Calculation
rates <- function(actual, predicted){
  positive_ii <- which(!!actual)
  negative_ii <- which(!actual)
  
  true_positive <- sum(predicted[positive_ii])/length(positive_ii)
  false_positive <- sum(predicted[negative_ii])/length(negative_ii)
  
  true_negative <- sum(!predicted[negative_ii])/length(negative_ii)
  false_negative <- sum(!predicted[positive_ii])/length(positive_ii)
  tibble(true_positive = true_positive,
         false_positive = false_positive,
         false_negative = false_negative,
         true_negative = true_negative,
         accuracy = sum(actual==predicted)/length(actual))
}

scores <- do.call(rbind, Map(function(threshold){
  predicted <- test$male_predict > threshold;
  actual <- test$male;
  rt <- rates(test$male, predicted);
  tpc <- sum((predicted==actual)[actual==1]);
  fpc <- sum((predicted==1)[actual==0]);
  fnc <- sum((predicted==0)[actual==1]);
  rt$precision <- tpc/(tpc+fpc);
  rt$recall <- tpc/(tpc+fnc);
  rt$f1 <- 2 * (rt$precision*rt$recall)/(rt$precision+rt$recall);
  rt$threshold <- threshold;
  rt;
}, seq(0, 1, length.out = 100)))

scores <- pivot_longer(scores, cols = true_positive:f1)
calculation <- ggplot(scores, aes(threshold, value)) + geom_line(aes(color = factor(name)))

ggsave("figures/emo_gender_calculation.png", calculation)