## Chapter 6. 데이터 랭글링
## 6.2. dplyr 패키지
## 6.2.4. 집단 관련 함수
## 6.2.4.1. summarise() 함수

library(tidyverse)
library(nycflights13)

# 출발 지연 시간 - 도착 지연 시간: 나에게 이득이 된 시간
flights %>% 
  mutate(gain = dep_delay - arr_delay, .after = day) %>%
  arrange(gain)      # 줄바꿈 할 때 파이프 연산자도 아랫줄로 내리면 안됨

# 속도 = 거리 / 비행시간 = miles / hour
flights %>% mutate(speed = distance / (air_time/60),
                   .before = 1)

## mutate()와 자주 쓰이는 함수
# 비행기 순서대로(데이터 순서대로) 번호 부여
flights %>% mutate(flight_order = row_number(), .before = 1)
   #(도움말)Help-min_rank
x <- c(1, 2, 2, 3, 5, NA)
# 1, 2,    2, 4, 5    # min_rank() : 동순위 발생 시  건너뜀 # 숫자 2가 동일한 랭크(등수) 니까 그냥 둘 다 2등 주고 3등 없는 취급
# 1, 2.5, 2.5, 4, 5
# 1,  2, 2, 3, 4      # dense_rank() : 동순위 발생 시 연속된 값 부여         #동순위에 대해서 똑같은 점수 주고 2들은 2등, 그 담은 3등
min_rank(x)
dense_rank(x)

# 출발 지연 시간의 순위(동순위 발생 시 건너 뜀)
flights %>% 
  mutate(delay_rank = min_rank(dep_delay), .before = 1) %>% 
  mutate(delay_dense = dense_rank(dep_delay), .after = 1)
  
# 출발 지연 시간이 만약 0이면, NA로 변환!
flights %>% 
  mutate(dep_delay_na = na_if(dep_delay, 0), .before = 1)

flights %>% 
  filter(dep_delay %in% c(-1,0,1)) %>% 
  relocate(dep_delay, .before = 1) %>% 
  mutate(dep_delay_na = na_if(dep_delay, 0), .before = 1)

# 결측값을 여러 열 중 첫번째 비결측값으로 변환
   # 도움말 coalesce
x <- c(1, 2, NA, NA, 5)
y <- c(NA, NA, 3, 4, 6)
   #data.frame(x, y)
coalesce(x, y)

# 출발 지연 시간이 NA인 경우에는 도착 지연 시간 사용
flights %>% 
  mutate(first_non_na = coalesce(dep_delay, arr_delay))










