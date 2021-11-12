library(readxl)
library(inspectdf)
library(caret)
library(rsample)
library(tidyverse)


#### 1. 데이터 불러오기 ####
# library(readxl)
rdata <- read_excel("종이컵비행기.xlsx", sheet=1)


#### 2. 데이터 전처리 ####
# library(inspectdf)
# library(tidyverse)
rdata %>% inspect_na() %>% show_plot()
data <- rdata %>% na.omit()


#### 3. 데이터 나누기 ####
# library(rsample)
splits <- initial_split(data, 0.8, strata=성능)
train <- training(splits)
test <- testing(splits)


#### 4. 모델 만들고 평가하기 ####
fit_rf <- train(성능~., train, method="rf")
predict(fit_rf, test) %>% postResample(test$성능)
predict(fit_rf, test) %>% plot(test$성능)


#### 5. 모델 해석하기 ####
summary(data)
test %>% 
    mutate(안쪽지름=5.5, 
           바깥쪽지름=7.7, 
           반너비=10.0, 
           # 무게=17.0, 
           감은횟수=2.3, 
           늘어난길이=23.5) %>% 
    mutate(예측값=predict(fit_rf, .)) %>% 
    ggplot(aes(x=무게, y=예측값)) + geom_point()
