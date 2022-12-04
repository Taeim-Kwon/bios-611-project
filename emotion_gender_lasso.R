library(tidyverse)
library(caret)
library(glmnet)

set.seed(1234)

emotion_gender <- read_csv("derived_data/emotion_gender.csv") %>% select(-1)

training <- emotion_gender$male %>% createDataPartition(p = 0.8, list = FALSE)

train.lasso <- emotion_gender[training, ]
test.lasso <- emotion_gender[-training, ]

x <- model.matrix(male~beauty+beauty_male+beauty_female+emo_anger+emo_disgust+emo_fear+emo_happiness+emo_neutral+emo_sadness+emo_surprise, train.lasso)[,-1]
y <- train.lasso$male
glmnet(x, y, family = "binomial", alpha = 1, lamda = NULL)

# Cross validation for optimal lamda
cv.lasso <- cv.glmnet(x, y, alpha = 1, family = "binomial")
coef(cv.lasso, cv.lasso$lambda.min)

png("figures/emo_beauty_lasso.png")
plot(cv.lasso)
dev.off()

# Lasso model with lambda.min
model.lambda.min <- glmnet(x, y, alpha = 1, family = "binomial", lamda = cv.lasso$lambda.min)

# Accuracy of model with lambda.min
x.test <- model.matrix(male~beauty+beauty_male+beauty_female+emo_anger+emo_disgust+emo_fear+emo_happiness+emo_neutral+emo_sadness+emo_surprise, test.lasso)[,-1]
probabilities <- model.lambda.min %>% predict(newx = x.test)
predicted <- ifelse(probabilities > 0.5, 1, 0)
observed <- test.lasso$male
mean(predicted == observed)

# Logistic model
log.model <- glm(male~beauty+beauty_male+beauty_female+emo_anger+emo_disgust+emo_fear+emo_happiness+emo_neutral+emo_surprise, train.lasso, family = "binomial")

summary(log.model)

# Accuracy of logistic model
probabilities <- log.model %>% predict(test.lasso, type = "response")
predicted <- ifelse(probabilities > 0.5, 1, 0)
observed <- test.lasso$male
mean(predicted == observed)