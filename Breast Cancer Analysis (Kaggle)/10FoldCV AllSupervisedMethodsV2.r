# Ranked in order of Accuracy: LR > DT > GLM > KNN > NB

library(class)              # K-Nearest Neighbour
library(rpart)              # Decision Tree
library(rpart.plot)         # Decision Tree
library(e1071)              # Naive Bayes
library(dplyr)              # Logistic Regression

cancer_data <- read.csv("CancerDataV2.csv")
cancer_data[, 1:15] <- lapply(cancer_data[, 1:15], scale)
n <- dim(cancer_data)[1]

# Seed 2022
set.seed(2022)

# 10-Fold Cross Validation
n_folds <- 10
folds_j <- sample(rep(1:n_folds, length.out = n))

# Accuracy vector: c(LR, KNN, DT, NB, GLM)
accuracy <- c(0, 0, 0, 0, 0)

for (j in 1:n_folds) {
test <- which(folds_j == j)
test_x <- cancer_data[test, 1:15]
test_y <- cancer_data[test, 16]
train <- cancer_data[-test, ]
train_x <- cancer_data[-test, 1:15]
train_y <- cancer_data[-test, 16]

# Linear Regression
lm_model <- lm(overall_survival ~ ., data = cancer_data)
lm_pred <- predict(lm_model, newdata = test_x) > 0.5
accuracy[1] <- accuracy[1] + sum(lm_pred == test_y)

# K-Nearest Neighbour
knn_pred <- knn(train_x, test_x, train_y, k = 30)
accuracy[2] <- accuracy[2] + sum(knn_pred == test_y)

# Decision Tree
dt_model <- rpart(overall_survival ~ ., method = "class", data = train,
                  control = rpart.control(minsplit = 1),
                  parms = list(split = "information"))
if (j == 0) {
rpart.plot(dt_model, type = 4, extra = 2, clip.right.labs = FALSE,
           varlen = 0, faclen = 0)
}
dt_pred <- predict(dt_model, newdata = test_x, type = "class")
accuracy[3] <- accuracy[3] + sum(dt_pred == test_y)

# Naive Bayes
nb_model <- naiveBayes(overall_survival ~ ., data = train)
nb_pred <- predict(nb_model, newdata = test_x)
accuracy[4] <- accuracy[4] + sum(nb_pred == test_y)

# Logistic Regression
glm_model <- glm(overall_survival ~ ., data = train)
glm_pred <- predict(glm_model, newdata = test_x) > 0.5
accuracy[5] <- accuracy[5] + sum(glm_pred == test_y)
}

accuracy <- accuracy / n
print(accuracy)