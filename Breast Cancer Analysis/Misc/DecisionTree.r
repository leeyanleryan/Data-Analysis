library(rpart)
library(rpart.plot)

cancer_data <- read.csv("CancerData.csv")
cancer_data[, 1:16] <- lapply(cancer_data[, 1:16], scale)
n <- dim(cancer_data)[1]

n_folds <- 10
folds_j <- sample(rep(1:n_folds, length.out = n))

cp <- 10^(-5:5)
accuracy <- rep(1, length(cp))

for (i in 1:10) {
correct <- 0
for (j in 1:n_folds) {
test <- which(folds_j == j)
test_x <- cancer_data[test, 1:16]
test_y <- cancer_data[test, 17]
train <- cancer_data[-test, ]

dt_model <- rpart(overall_survival ~ .,
                  method = "class", data = train,
                  control = rpart.control(cp = cp[i], minsplit = 1),
                  parms = list(split = "information"))
dt_pred <- predict(dt_model, newdata = test_x, type = "class")
correct <- correct + sum(dt_pred == test_y)
}
accuracy[i] <- correct / n
}

# Plot graph of complexity parameter against accuracy
plot(log(cp, base = 10), accuracy, type = "b")

# Using best complexity parameter
best_cp <- cp[which(accuracy == max(accuracy))]
dt_model <- rpart(overall_survival ~ .,
                  method = "class", data = cancer_data,
                  control = rpart.control(cp = best_cp, minsplit = 1),
                  parms = list(split = "information"))
rpart.plot(dt_model, type = 4, extra = 2, clip.right.labs = FALSE,
           varlen = 0, faclen = 0)

# Normal plotting
dt_model <- rpart(overall_survival ~ .,
                  method = "class", data = cancer_data,
                  control = rpart.control(minsplit = 1),
                  parms = list(split = "information"))
rpart.plot(dt_model, type = 4, extra = 2, clip.right.labs = FALSE,
           varlen = 0, faclen = 0)