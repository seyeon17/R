## chapter 6. 데이터 랭글링
## 6.3. tidyr 패키지
setwd(C:/Users/default.DESKTOP-VHFHFGU)

library(tidyverse)
mydata <- read_csv("mydata.csv",
                   locale = locale(encoding = "CP949"))
mydata


## 6.2.4.2. mutate() 함수 이렇게도 된다!
library(nycflights13)
flights %>%
  mutate(flight_grade = case_when(
    distance < 500 ~ "Short-haul",     #if(diatance < 500)
    distance  < 1500 ~ "Medium-haul",  #else if(distance < 1500)
    distance >= 1500 ~ "Long-haul"     #else if(distance >= 1500)
  ))

flights %>%
  mutate(flight_grade = case_when(
    distance < 500 ~ "Short-haul",     #if(diatance < 500)
    distance  < 1500 ~ "Medium-haul",  #else if(distance < 1500)
    TRUE ~ "Long-haul"                 #else
  ))


## 6.3. tidyr 패키지
## 6.3.1. wide formar과 long format
# tidyr 패키지
table1
table2
table3
table4a
table4b # table1이랑 비교하면 table1을 와이드 폼으로 바꾼 것
table5  # 1999년이면 19, 99 분리




















