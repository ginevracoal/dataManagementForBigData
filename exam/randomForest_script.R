projects <- read_csv("kickstarter-projects/ks-projects-201801.csv")

# removing unnecessary column about pledged money
projects <- projects %>% 
  rename(drop = 'usd pledged') %>% 
  select(-drop)

# 4 rows have missing names, so I drop them
projects <- projects %>% 
  filter(!is.na(projects$name)) 

projects <- projects %>% filter(state != "undefined")

# coverting binary state into bool
bool_projects <- projects %>%
  filter(state %in% c("successful", "failed")) %>%
  mutate(binary_state = state=="successful")

# bool_projects %>% select(state, binary_state)

bool_projects$binary_state <- as.integer(as.logical(bool_projects$binary_state))

# have to subset data
subset_bool_projects <- bool_projects[1:8000,]
size <- nrow(subset_bool_projects)

# transform categorical predictor into factors
subset_bool_projects$main_category <- as.factor(subset_bool_projects$main_category)

rf_train <- subset_bool_projects[1:size*0.6,]
rf_test <- subset_bool_projects[(size*0.6+1):size,] 

# fit random forest
rf_fit <- randomForest(binary_state ~ goal + main_category, data=rf_train)

# summary(fit)

rf_probabilities <- predict(rf_fit, rf_test)

# from probabilities to binary classification
rf_predictions <- ifelse(rf_probabilities > 0.5, 1, 0) 

# measuring accuracy of the predictions
rf_misClasificError <- mean(rf_predictions != rf_test$binary_state)

print(paste('Accuracy', 1-rf_misClasificError))

# table of predictions
table(actual=rf_test$binary_state, predicted=rf_predictions)