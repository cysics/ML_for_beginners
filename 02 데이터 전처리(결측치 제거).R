library(readxl)
library(inspectdf)
library(tidyverse)


#### 1. 데이터 불러오기 ####
# library(readxl)
rdata <- read_excel("종이컵비행기.xlsx", sheet=1)


#### 2. 데이터 전처리 ####
# library(inspectdf)
# library(tidyverse)
rdata %>% inspect_na() %>% show_plot()
data <- rdata %>% na.omit()
