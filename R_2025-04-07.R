## 아놔 앞에 다 날아감 ㅡㅡ; 사진 찍어놓은거 4:45 코드 쳐두기

## Chapter 5. tidyverse 통합패키지
## 5.5. tibble 패키지
## 5.5.2. tibble 이해
library(tidyverse)
mytbl <-  tibble(
  x= 1:5,
  y = 1,
  z = x^2 + y
)
mytbl

mydf <- data.frame(mytbl)    #as.data.frame()과 같음!
mydf                  

class (mydf [, 1:2])
class (mydf [, 1])

class(mytbl [, 1:2])
class (mytbl [, 1])

class (mytbl [[1]])
class (mytbl$x)

## Chapter 6. 데이터 랭글링
## 6.1. readr 패키지
# data <- read_csv("C:/Users/default.DESKTOP-VHFHFGU/Downloads/StudentSurvey.csv")
data <- read_csv("StudentSurvey.csv")    # 이렇게 해도 된다!

## 6.2. dplyr 패키지
# flights 데이터셋
library(nycflights13)
flights %>%  str
flights %>%  glimpse

# 120분 이상 연착한 항공편 
flights %>% filter(arr_delay >= 120)

# 1월 1일에 출발한 항공편
flights %>% filter(month == 1 & day == 1)    # 842개!
flights %>% filter(month == 1, day == 1)     # 위와 결과 같음

# 3, 5, 8월에 출발한 항공편
flights %>% filter(month %in% c(3, 5, 8))

## 6.2.2.2. arrange() 함수
# 출발날짜 + 시간 순으로 정렬
flights %>% arrange(year, month, day, dep_time)

# 가장 출발 지연 시간이 길었던 항공편 확인
flights %>% arrange(desc(dep_delay))
flights %>% arrange(dep_delay) %>% select(dep_delay)  # -는 일찍 출발했다는 의미

# 대략 정시에 출발한 항공편 중에서
# --> 실제 출발 시간과 예정된 출발 시간의 차이가
#     10분 이내인 경우를 대략 정시 출발로 판단
# 가장 늦게 도착한(도착 지연이 길었던) 항공편 확인

flights %>% 
  filter(dep_delay <= 10 & dep_delay >= -10) %>% 
  arrange(desc(arr_delay))

## 6.2.3. 열 관련 함수
## 6.2.3.1. select() 함수
# 출발 연월일 변수 추출
flights %>% select(year, month, day)
flights %>% select(year:day)

# 출발 연월일 변수 제외 나머지 변수 추출
flights %>% select(-(year:day))

# 변수 이름 변경
flights %>% 
  select(dep.time = dep_time, 
         arr.time = arr_time)

flights %>% 
  select(dep.time = dep_time, 
         arr.time = arr_time)


# 변수 이름이 "sched"로 시작하는 경우
flights %>% select(starts_with("sched"))
flights %>% select(ends_with("time"))
flights %>% select(contains("arr"))  # 변수 이름에 arr만 들어가면 추출



## jump
## 6.2.3.3. rename() 함수
flights %>% 
  rename(dep.time = dep_time, 
         arr.time = arr_time) %>% 
  glimpse

## 6.2.3.4. relocate() 함수
flights %>% 
  filter(dep_delay <= 10 & dep_delay >= -10) %>% 
  arrange(desc(arr_delay)) %>% 
  relocate(arr_delay)   # 맨 앞으로 가져옴

# 만약에 출발 날짜 앞 or 뒤에 나오게 하고 싶으면? .before .after 사용 가능
flights %>% 
  filter(dep_delay <= 10 & dep_delay >= -10) %>% 
  arrange(desc(arr_delay)) %>% 
  relocate(arr_delay, .after = day) 

flights %>% relocate(air_time, distance)
flights %>% relocate(carrier:tailnum, .before = day)



















