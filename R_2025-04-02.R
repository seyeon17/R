## chapter 5. tidyverse 통합 패키지
## 5.4. 파이프 연산자
library(tidyverse)

# magrittr 파이프 연산자 %>% 

mtcars %>% head()            # = head(mtcars)
mtcars %>% head              #이렇게 해도 됨
mtcars %>% head(2)           # = head(mtcars, 2)
mtcars %>% lm(mpg~disp, .)    
mtcars %>% .$gear

###         lm(mpg~disp, mtcars)
###         lm(종속변수~독립변수, dataset)  #얘네들은 몰라도 된다


# R 기본 파이프 연산자 |>
mtcars |> head()
mtcars |> head              # Error! 얘는 괄호 없으면 안됨
mtcars |> head(2)
mtcars |> lm(mpg~disp, _)   # Error! 파라미터 이름 써 줘야함.
mtcars |> lm(mpg~disp, data = _)

## 5.5. tibble 패키지
## 5.5.1. tibble 
library(nycflights13)
flights
flights %>% view()            # 전체를 보고싶을 때는 이렇게!

## 5.5.2. tibble의 이해
library(tibble) # 타이디벌스를 불러왔기 때문에 티블(타이디벌스에 포함) 안 불러와도 됨
mydf <- data.frame(
  x = 1:5,
  y = 1
  # z = x^2 + y (불가능) 
)

mydf



mytbl <- tibble(
  x = 1:5,
  y = 1,
  z = x^2 + y,
  '1st' = 11:15,
  '2nd' = 21:25,
  '@DFJSJ' = 31:35
)                         #변수 이름 지정 유연! ''

mytbl


iris
as_tibble(iris)
iris %>% as_tibble

as.data.frame(flights)
flights 






