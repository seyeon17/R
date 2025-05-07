## chapter 6. 데이터 랭글링
## 6.4. stringr 패키지
## 6.4.2. 문자열 기초
## 6.4.2.1. str_length() 함수

library(tidyverse)
str = c("a", "R for data science", NA)
str_length(str)

library(babynames)

# 이름 길이의 분포 (한글자 이름을 가지는 아이는 몇명? 두글자는?)
babynames %>% 
  mutate(name_len = str_length(name)) %>% 
  group_by(name_len) %>% 
  summarise(n = sum(n))

babynames %>% 
  count(name_len = str_length(name), wt = n)  # 위에거 간결하게 이렇게!

babynames %>% 
  filter(str_length(name) == 15)  %>% # 연도, 성별도 다 짬뽕임
  count(name, wt = n)                 # 이렇게 해야함

## 6.4.2.2. str_sub() 함수

# Example: str_sub()
x <- c("Apple", "Banana", "Pear")

# 1번째 문자부터 3번째 문자까지 추출
str_sub(x,1,3)

# 끝에서 3번째 문자부터 마지막 문자까지 추출
str_sub(x, -3, -1 )

# 문자열이 짧아도 에러는 발생하지 않음! 
str_sub("a", 1, 5)  

babynames %>% 
  mutate(first = str_sub(name, 1, 1),
         last = str_sub(name, -1, -1))

## 6.4.2.3. str_to_lower(), str_to_upper() 함수
str_to_lower(c("Apple", "Banana", "Pear"))
str_to_upper(c("Apple", "Banana", "Pear"))

## 6.4.3. 데이터에서 문자열 생성
## 6.4.3.1. str_c() 함수
letters  # A to Z 소문자
LETTERS  # A to Z 대문자

str_c("Letter: ", letters)
str_c("Letter", letters, sep = ": ") # 구분자를 넣고싶다면 sep = 파라미터 사용!
str_c(letters, " is for", "...")

# 만약에 이걸 만들고 싶다면?
"a comes before b"
"b comes before c"
...
"y comes before z"
str_c(letters[-26], " comes before ", letters[-1])

# 단일 문자열(single string)로 결합
str_c(letters, collapse = "")
str_c(letters, collapse = ",") # 하나의 문자열이 이렇게 나와있는 것

# 결측값이 있는 경우
x <- c("a", NA, "b")
str_c(x, "-d")
  # NA-d로 나오길 바란다면?
str_c(str_replace_na(x), "-d")   # 결측값을 "NA" 그대로 출력

# mutate()와 함께 사용
info <- tibble(name = c("Kim", "Lee", "Park"))
info
  # 앞에 hi를 붙이고 싶어 뒤에는 느낌표
info %>% mutate(greeting = str_c("Hi ", name, "!"))

## 6.4.3.2. str_glue() 함수
name <- "Park"
str_c("Hello ", name, "!")
str_glue("Hello,  {name}!") # 중괄호 표현식은 문자열의 외부에서 평가되어 있는 값으로 치환되어 반환
str_glue("2 + 3 = {2+3}")  
str_glue("Today is {str_to_upper('monday')}")  #작따 큰따 다르게 해야된다는거 주의!


