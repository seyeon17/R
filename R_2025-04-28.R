## Chapter 6. 데이터 랭글링
## 6.3. tidyr 패키지
## 6.3.2. long format으로 변환

library(tidyverse)

# long format 변환1
table4a %>%
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases") %>% 
  mutate(year = parse_integer(year))   

# long format 변환2
table4b %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "population") %>% 
  mutate(year = parse_integer(year))

# long format 변환3 
relig_income %>% 
  pivot_longer(-religion, names_to = "income", values_to = "count")


# long format 변환4, 트랙마다 
billboard %>% 
  pivot_longer(cols = starts_with("wk"),
               names_to = "week",
               names_prefix = "wk",  # wk 문자를 빼고 보여줌!
               values_to = "rank",
               values_drop_na = TRUE) %>%   # 이걸 트루로 설정하면 결측값 사라짐
  mutate(week = parse_integer(week)) %>% 
  head(17)


## 6.3.3. wide format 변환
# wide format 변환1
table2 %>% 
  pivot_wider(names_from = type,
              values_from = count)

table2 %>%
  pivot_wider(names_from = type,
              values_from = count) %>%                                # type에 대한 wide format
  mutate(rate = cases/population*100000) %>%                          # 인구 10만 명당 결핵 건수
  pivot_wider(names_from = year,                                      # year에 대한 wide format
              values_from = c(cases, population, rate)) %>%
  relocate(country, contains("1999"))                                 # 변수 위치 변경


# wide format 변환2
fish_encounters %>% 
  pivot_wider(names_from = station,
              values_from = seen,
              values_fill = 0)  # 결측값을 0으로 표현


## 6.3.4. 열의 분리 및 결합
# 열의 분리
table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/") %>% 
  mutate(cases = parse_integer(cases),
         population = parse_integer(population))

# 열의 결합
table5 %>% 
  unite(col = new_year, century, year, sep = "") %>% 
  mutate(new_year = parse_integer(new_year))
                # 분리/ 결합시 구분자 잘 설정해라

## 6.3.5. 결측값 처리
# 결측값 처리(전염성 있음)
x <- c(1,2,3,NA)
x <- c(1,2,3)         # NA 때문에 계산 안됨
sum(x, na.rm = T)     # 계산 O

NA + 10
NA / 2
NA>5
10 == NA

a <- NA
is.na(a)    # 결측값 확인 함수
a == NA     # 안된다..

# 2015년 4분기 수익은 NA로 표시되어 있으므로, 명시적 결측값임
# 2016년 1분기 수익은 데이터셋이 존재하지 않으므로, 암묵적 결측값임
# 명시적 결측값과 암묵적 결측값
stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)) 
   # 2015년 4분기, 명시적 결측값
   # 2016년 1분기, 암묵적 결측값(없으니까)

stocks %>% 
  pivot_wider(names_from = year,
              values_from = return) %>% 
  pivot_longer(c(`2015`, `2016`),
               names_to = "year",
               values_to = "return",
               values_drop_na = TRUE)   # <- 결측값 없애고 싶으면


# complete() 예제
stocks %>% complete(year, qtr)

mytbl <- tibble(x = c(1,2,NA),
                y = c("a", NA, "b"))

# drop_na() 예제
mytbl %>% drop_na()  # 결측값이 포함된 행 제거
mytbl %>% drop_na(x) # x 변수에서 결측값이 있는 행 제거

  # x 변수의 결측값은 0, y 변수의 결측값은 'unknown'으로 대체
mytbl %>% 
  replace_na(list(x = 0, y = "unknown"))

mytbl$x %>% 
  replace_na(0)

mytbl %>% mutate(x = replace_na(x, 0))

# fill() 예제
tibble(person = c("Derrick Whitmore", NA, NA, "Katherine Burke"),
       treatment = c(1, 2, 3, 1), response = c(7, 10, 9, 4)) %>% 
  fill(person)   # 직전의 데이터 값으로 대체

















