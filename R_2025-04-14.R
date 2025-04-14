## Chapter 6. 데이터 랭글링
## 6.2. dplyr 패키지

library(tidyverse)
library(nycflights13)


# 비행 시간이 3시간 이상이면 Long Flight,
# 3시간 미만이면 Short Flight
flights %>% mutate(time_group = if_else(air_time >= 180,
                                        "Long Flight",
                                        "Short Flight"
                                    )) %>% 
  relocate(air_time, time_group)  # if-else 문과 같음! 언더바만 다른거

# 비행거리 기준으로 그룹화
flights %>%  
  mutate(distance_group = case_when(distance < 500 ~ "Short haul",
                                    distance >= 500 & distance , 1500 ~ "Medium haul",
                                    distance >= 1500 ~ "Long haul")) %>% 
  relocate(distance, distance_group)

# 항공사 이름 변경
flights %>%  
  mutate(carrier_name = recode(carrier,
                               "AA" = "American Airlines",
                               "DL" = "Delta Airlines")) %>% 
  relocate(carrier, carrier_name)

mbti <- tibble(mbti = c("ESTJ", "ISFJ", "INTP",
                        "ESTP"))
mbti %>% mutate(group = recode(mbti,
                               "ESTJ" = "E",
                               "ESTP" = "E",
                               "ISFJ"= "I",
                               "INTP" = "I"))

## 6.2.4. 집단 관련 함수
## 6.2.4.1. summarise() 함수
flights %>% summarise(mean = mean(air_time))  # 결측값이 있어서 이렇게 계산됨

flights %>% summarise(n = n(),
                      mean = mean(air_time, na.rm = TRUE),
                      std_dev = sd(air_time, na.rm = TRUE),
                      '1st' = first(air_time),
                      last_value = last(air_time))

## 6.2.4.2. group_by() 함수
flights %>% 
  group_by(month) %>% 
  summarise(n = n(),
            delay = mean(dep_delay, na.rm = TRUE))

# 여러 개로 그룹화 가능
flights %>% 
  group_by(month, day) %>% 
  summarise(n = n())

# ungroup을 통해 그룹화를 풀 수 있음
flights %>% group_by(month) %>% ungroup() %>% summarise(n = n())

# 항공사 별로 항공편 개수 (빈도표를 그려보고 싶어)
flights %>%
  group_by(carrier) %>% 
  summarise(n = n())


## 6.2.4.3. count() 함수
flights %>% count(carrier) #   group_by(carrier) %>% summarise(n = n())

# 1년간의 총 비행시간을 알고싶어
flights %>% count(carrier, wt = air_time)


## 6.2.5. 관계형 데이터
## 6.2.5.2 키(key)
# 기본 키 중복 확인
planes %>% count(tailnum) %>% filter(n > 1)  # n이 1 초과인게 있으면 기본키 아님!
flights %>% count(tailnum) %>% filter(n > 1)
flights %>% count(flight)

weather %>% count(year, month, day, hour, origin) %>%  filter(n > 1)
# 일반적으로 기본키와 외래키는 일대다 관계지만,
# 학번 가지고 하는 경우에는 일대일 관계 형성



## 6.2.5.3. 뮤테이팅 조인
x <- tibble(key = c(1, 2, 3), value_x = c("x1", "x2", "x3"))
y <- tibble(key = c(1, 2, 4), value_y = c("y1", "y2", "y3"))

x %>% inner_join(y, by ="key")
x %>% left_join(y, by = "key")
x %>%  right_join(y, by = "key")
x %>%  full_join(y, by = "key")

# flights 데이터셋 일부 추출
flights2 <- flights %>% select(year, month, day, hour, origin, dest, tailnum, carrier)

# flights2 와 weather 조인 
# by = NULL (기본값)
# 두 테이블에 있는 모든 변수를 사용해서 조인(natural join)
flights2 %>% left_join(weather)


# flights2 와 planes 조인
# flights와 planes에는 year 변수가 있지만 서로 다른 의미!
# tailnum 변수로만 조인

planes %>% glimpse

flights2 %>% left_join(planes, by = "tailnum")


# flights2와 aitports 조인
# 테이블 x의 a 변수와 테이블 y의 b 변수를 매칭
flights2
airports
flights2 %>% left_join(airports, by = c("origin" = "faa"))
flights2 %>% left_join(airports, by = c("dest" = "faa")) %>%  glimpse()

## 6.2.5.4. 필터링 조인
# 가장 인기있는 상위 10개 도착지 
top_dest <- flights %>% count(dest) %>% arrange(desc(n)) %>% head(10)
# == flights %>% count(dest, sort = TRUE) %>% head(10)
top_dest

# 전체 운행 데이터에서 목적지 중 한 곳으로 운행한 항공편 필터링
flights %>% semi_join(top_dest) #141,145

# 매칭되지 않는 항공편 필터링
flights %>% anti_join(top_dest)  #195,631

141145+195631
flights
# 뮤테이팅, 필터링 조인 차이점!




































