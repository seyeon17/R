## 6.5.2 팩터 수준(levels) 재정렬


## fct_reorder() 예제
library(tidyverse)

# 결혼 상태에 따른 하루 평균 TV 시청 시간
summary1 <- gss_cat %>% 
  group_by(marital) %>% 
  summarise(tvhours = mean(tvhours, na.rm = TRUE),
            n = n()) %>%
  mutate(marital = fct_reorder(marital, tvhours))
  

summary1$marital %>% levels

## [그래프를 통한 확인]
library(ggplot2)
ggplot(summary1, aes(tvhours, marital)) +
  geom_point(size = 3) +
  theme(axis.title = element_text(size = 15),
        axis.text = element_text(size = 15))

## fct_relevel() 예제
# 소득에 따른 평균 연령
gss_cat %>% count(rincome)
summary2 <- gss_cat %>% 
  group_by(rincome) %>% 
  summarise(age = mean(age, na.rm = TRUE),
            n = n())

# Not applicable을 이동시키고 싶으면 ↘
ggplot(summary2, aes(x = fct_relevel(rincome, "Not applicable"), 
                     y = age)) +
  geom_bar(stat = "identity") +
  coord_flip() + 
  theme(axis.text = element_text((size =15)))

# 범주형 변수 -> 명목 척도 (그냥 집단 별로 구별, 성별, 종교 등), 서열(순서) 척도(소득)
# 연속형 변수 -> 비율척도, 등간척도



## 6.5.3. 팩터 수준(levels) 변경
# a b c d e
# a, b는 --> AA로 묶고
# c d e는 --> BB로 묶고싶음
# "AA" = c("a", "b")
# "BB" = 


## fct_recode() 예제1
gss_cat %>% count(partyid)


gss_cat %>%
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong"    = "Strong republican",
                              "Republican, weak"      = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"        = "Not str democrat",
                              "Democrat, strong"      = "Strong democrat")) %>%
  count(partyid)

## fct_recode() 예제2
# 좀 묶어야겠어.. 123번 묶어보자, Other라는 카테고리로!
gss_cat %>%
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong"    = "Strong republican",
                              "Republican, weak"      = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"        = "Not str democrat",
                              "Democrat, strong"      = "Strong democrat",
                              "Other" = "Don't know",
                              "Other"= "No answer",
                              "Other" = "Other party")) %>%
  count(partyid)
## fct_collapse() 예제1
# 더 묶어보자
# 위와 방식 다름. 
gss_cat %>%
  mutate(partyid = fct_collapse(partyid,
                                other = c("No answer", "Don't know", "Other party"),
                                rep = c("Strong republican", "Not str republican"),
                                ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                                dem = c("Not str democrat", "Strong democrat"))) %>%
  count(partyid)

## fct_lump() 예제1
gss_cat %>% count(relig)

gss_cat %>%
  mutate(relig = fct_lump(relig)) %>%
  count(relig)

## fct_lump() 예제2
gss_cat %>% 
  mutate(relig = fct_lump(relig, n = 10), other_level = "Others...") %>%
           count(relig, sort = TRUE)

## fct_lump() 예제3  
gss_cat %>% 
    mutate(relig = fct_lump(relig, prop = 0.05), other_level = "Others...") %>% 
             count(relig, sort = TRUE)
           
  
  
## fct_lump() 예제2


## 6.6. lubridate 패키지
## 6.6.2 날짜/시간 생성

library(lubridate)
today()
now()

# 연-월-일 
dt <- ymd("2017-01-31")
class(dt)


# 월 일, 년
dt2 <- mdy("January 31st, 2017")
class(dt2)

# 일-월-년
dt3 <- dmy("31-Jan-2017")
class(dt3)

# 년-월-일 시:분:초
dttml <- ymd_hms("2017-01-31 20:11:59")
is(dttml)
class(dttml)

# 월/일/년 시:분
mdy_hm("01/31/2017 08:11")

## 6.6.2.3 개별 구성요소로부터 생성
library(nycflights13)

flights %>% glimpse

flights %>% 
  select(year, month, day, hour, minute) %>% 
  mutate(departure = make_datetime(year, month, day, hour, minute))



# 시(hour)와 분을 각각 분리하여 추출한 후,
# make_datetime()을 이용하여 date-time 생성

time <- 815
time %/% 100  # 나눗셈의 몫을 계산하는 연산자 %/%
time %% 100   # 나눗셈의 나머지를 계산하는 연산자 %%

make_datetime_100 <- function(year, month, day, time) {
  return(make_datetime(year, month, day, time %/% 100, time %% 100))
}


flights_dt <- flights %>% 
  filter(!is.na(dep_time), !is.na(arr_time)) %>% 
  mutate(dep_time = make_datetime_100(year, month, day, dep_time),
         arr_time = make_datetime_100(year, month, day, arr_time),
         sched_dep_time = make_datetime_100(year, month, day, sched_dep_time),
         sched_arr_time = make_datetime_100(year, month, day, sched_arr_time)) %>% 
  select(origin, dest, ends_with("time"), ends_with("delay"))
  

## 6.6.2.4. 기존의 날짜/시간로부터 생성
as_datetime(today())
as_date(now())



wday(today())
mday(today())
yday(today())




td <- "2025-05-19 17:32:55"
year(td)
month(td)
month(td, label = TRUE, abbr = FALSE)
day(td)
hour(td)
minute(td)
second(td)

yday(td)
mday(td)
# "n요일"까지 보고싶으면 이렇게
wday(td, label = TRUE, abbr = FALSE)


## 6.6.4. 시간 범위
## 6.6.4.1. 시간 범위 유형
## 6.6.4.2 duration

today() - ymd(20250302)
as.duration(dday)

dseconds(15) 
dminutes(10)
dhours(c(12,24))
ddays(0:5)
dweeks(3)
dmonths(1:6)
dyears(1)


# 덧셈, 뺄셈, 곱셈 연산
dyears(1) + dweeks(12) + dhours(15)
2 * dyears(1)

tomorrow <- today() + ddays(1)    # 2026년
last_year <- today() - dyears(1)  # 2024년


# 일광 절약 시간제
one_pm <- ymd_hms("2025-03-08 13:00:00", tz = "America/New_York")
one_pm
one_pm + ddays(1)
