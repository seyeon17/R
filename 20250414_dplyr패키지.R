## Date: 2025-04-14
## Author: OJK

# chapter 6.2 dplyr 패키지
## 6.2.3.2. mutate() 함수
library(tidyverse)
library(nycflights13)

# 비행시간이 3시간 이상이면 Long Flight,
# 3시간 미만이면 Short Flight
flights %>% 
  mutate(time_group = if_else(air_time >= 180,
                              "Long Flight", 
                              "Short Flight")) %>%
  relocate(air_time, time_group)

# 비행 거리 기준으로 그룹화
flights %>% 
  mutate(distance_group = case_when(distance < 500 ~ "Short haul",
                                    distance >= 500 & distance < 1500 ~ "Medium haul",
                                    distance >= 1500 ~ "Long haul")) %>% 
  relocate(distance, distance_group)


# 항공사 이름 변경
flights %>% 
  mutate(carrier_name = recode(carrier,
                               "AA" = "American Airline Inc.",
                               "DL" = "Delta Air Lines Inc.")) %>% 
  relocate(carrier, carrier_name)

# MBTI 이름 변경
mbti <- tibble(mbti = c("ESTJ", "ISFJ", "INTP", "ESTP"))
mbti %>% mutate(group = recode(mbti,
                               "ESTJ" = "E",
                               "ESTP" = "E",
                               "ISFJ" = "I",
                               "INTP" = "I"))

## 6.2.4. 집단 관련 함수
### 6.2.4.1 summarize() 함수
# 전체 데이터 대상으로 요약
flights %>% summarize(n = n(),
                      mean = mean(air_time, na.rm = TRUE),
                      std_dev = sd(air_time, na.rm = TRUE),
                      `1st` = first(air_time),
                      last_value = last(air_time))

### 6.2.4.2. group_by() 함수
# 특정 변수(집단)를 기준으로 그룹화
# 여러 변수를 기준으로 그룹화 가능
flights %>% 
  group_by(month) %>% 
  summarize(n = n(),
            delay = mean(dep_delay, na.rm = T))

flights %>% 
  group_by(month, day) %>% 
  summarize(n = n())

flights %>% group_by(month) %>% ungroup() %>% summarize(n = n())

# 항공사별 항공편 개수
flights %>% 
  group_by(carrier) %>% 
  summarise(n = n())

flights %>% count(carrier)

# 항공사별 비행 시간 총합
flights %>% count(carrier, wt = air_time)

## 6.2.5. 관계형 데이터
### 6.2.5.1. 관계형 데이터 소개
# 여러 데이터 테이블을 총칭하여 관계형 데이터라 부름
airlines
airports
planes
weather

### 6.2.5.2. 키(Key)
# 기본키: 한 테이블 내에서 각 관측값을 고유하게 식별하는 변수
# 예. 출석부 내에서 학번은 고유변수
# 외래키: 다른 테이블의 기본키를 참조하여 두 테이블을 연결하는 변수

# 기본키는 반드시 모든 관측값을 유일하게 식별해야 하므로, 중복이 없는지 확인해야 함
planes %>% count(tailnum) %>% filter(n > 1) # 기본 키 중복 확인
flights %>% count(tailnum) %>% filter(n > 1) # 값이 나오므로 기본 키 아님
# 일부 테이블은 명시적으로 기본키가 정의되어 있지 않기도 함
# 외래키
weather %>% count(year, month, day, hour, origin) %>%
  filter(n > 1)

### 6.2.5.3. 뮤테이팅 조인
x <- tibble(key = c(1, 2, 3), value_x = c("x1", "x2", "x3"))
y <- tibble(key = c(1, 2, 4), value_y = c("y1", "y2", "y3"))

x %>% inner_join(y, by ="key")
x %>% left_join(y, by = "key")
x %>% right_join(y, by = "key")
x %>% full_join(y, by = "key")
full_join(x,y)

## flights 데이터셋 일부 추출
flights2 <- flights %>% 
  select(year, month, day, hour, origin, dest, tailnum, carrier)

## flights2와 weather 조인
# by = NULL (기본값)
# 두 테이블에 있는 모든 변수를 사용해서 조인(natural join)
flights2 %>% left_join(weather)

## flights2와 planes 조인
# flights2와 planes에는 year 변수가 있지만 서로 다른 의미임
# tailnum 변수로만 조인
planes %>% glimpse
flights2 %>% left_join(planes, by = "tailnum")

## flights2와 airports 조인
# 테이블 x의 a 변수와 테이블 y의 b 변수를 매칭
flights2 %>% left_join(airports, by = c("dest" = "faa"))
flights2 %>% left_join(airports, by = c("origin" = "faa")) %>% glimpse

### 6.2.5.4. 필터링 조인
# 변수 결합x, 관측값 자체를 필터링함
# x테이블의 값만 나옴, 매칭 여부만 중요하며, 매칭된 값은 중요칭 않음

# 가장 인기있는 상위 10개 도착지
top_dest <- flights %>% count(dest) %>% arrange(desc(n)) %>% head(10)
#flights %>% count(dest, sort = T) %>% head(10)  # 위 코드와 같음

# 전체 운행 데이터에서 목적지 중 한곳으로 운행한 항공편 필터링
flights %>% semi_join(top_dest)  # 141,145

# 매칭되지 않는 항공편 필터링
flights %>% anti_join(top_dest)  # 195,631`
`