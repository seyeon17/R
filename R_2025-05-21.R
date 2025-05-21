## 6.6. lubridate 패키지
## 6.6.4.3. period
library(tidyverse)
library(lubridate)



seconds(15)
minutes(10)
hours(c(12, 24))
days(0:5)
weeks(3)
months(1:6)
years(1)

## Example 2
# 덧셈, 뺄셈, 곱셈 연산
10 * (months(6) + days(1))
days(50) + hours(25) + minutes(2)


# 일광 절약 시간제
one_pm <- ymd_hms("2025-03-08 13:00:00", tz = "America/New_York")
one_pm                                  # "2025-03-08 13:00:00 EST"
# 썸머타임 때문에 한 시간 추가됨
one_pm + ddays(1)                       # "2025-03-09 14:00:00 EDT"
one_pm + days(1)  


# 윤년
ymd("2024-01-01") + dyears(1)

library(nycflights13)


## Example2
# 예정된 도착 일시, 실제 출발 일시, 실제 도착 일시를 date-time 형식으로 생성
# → sched_arr_time, dep_time, arr_time은 HHMM 또는 HMM 형식으로 되어 있어,
#   시(hour)와 분(minute)을 각각 분리하여 추출해야 함
make_datetime_100 <- function(year, month, day, time) {
  make_datetime(year, month, day, time %/% 100, time %% 100)
}

flights_dt <- flights %>% 
  filter(!is.na(dep_time), !is.na(arr_time)) %>% 
  mutate(dep_time = make_datetime_100(year, month, day, dep_time),
         arr_time = make_datetime_100(year, month, day, arr_time),
         sched_dep_time = make_datetime_100(year, month, day, sched_dep_time),
         sched_arr_time = make_datetime_100(year, month, day, sched_arr_time)) %>% 
  select(origin, dest, ends_with("delay"), ends_with("time"))


# 자정 이후 도착한 항공편(심야 항공편)의 도착 일시에는
# 하루를 더해줘야 함
flights_dt %>%
  select(dep_time, arr_time) %>% 
  filter(arr_time < dep_time)

flights_dt <-  flights_dt %>% 
  mutate(overnight = arr_time < dep_time,
         arr_time = arr_time + days(overnight * 1))

   # 오버나잇이 트루인 경우 
flights_dt %>% 
    select(dep_time, arr_time, overnight) %>% 
    filter(arr_time < dep_time)
  
# interval 생성
next_year <- today() + years(1)
interval(today(), next_year)
today() %--% next_year

# interval 기간
years(1) / days(1)
dyears(1) / ddays(1)

(today() %--% next_year) /ddays(1)

(ymd("2024-01-01") %--% ymd("2025-01-01")) / ddays(1) # 작년에는 윤년이라 366일


## chapter 7. 데이터 시각화
## 7.3.3. 막대 그래프(bar chart)
diamonds

# 컷 품질에 대한 막대 그래프
ggplot(diamonds)





