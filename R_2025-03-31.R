## chapter 4. 프로그래밍 구조
## 4.3, 반복문
## 4.3.3. apply 계열 함수

# apply() 예제: 행별 평균(MARGIN = 1)
# 데이터프레임에서 각 행의 평균 계산
# 두 번째 매개변수는 1이면 행에, 2이면 열에 적용
head(iris,3)
apply(iris[, 1:4], 1, mean)


# apply() 예제: 열별 평균 (MARGIN = 2)
# 데이터 프레임에서 각 열의 평균
apply(iris[, -5], 2, mean)


# lapply(): 열별 요약 통계량
res <- lapply(iris[,1:4], summary)
res$Sepal.Length

# sapply(): 열별 요약 통계량
sapply(iris[,1:4], summary)  #class, is 씌워서 자료형 확인할 수 있음



# vapply(): 열별 평균을 숫자로 반환
vapply(iris[,1:4], mean, numeric(1))

#tapply(): Species별로 Sepal.Length의 평균 계산
tapply(iris$Sepal.Length, iris$Species, mean)


# mapply(): Sepal.Length와 Sepal.Width의 합
mapply(sum, iris$Sepal.Length, iris$Sepal.Width) #헹뱔로 평균내는거
apply(iris[, 1:2], 1, sum)        #이렇게 해도 똑같다.


## 4.4. 사용자 정의 함수
# 두 개의 값을 입력받아 큰 수를 반환하는 함수
mymax <- function(x, y) {
  if(x > y) {
    max.value <- x
  } else {
    max.value <-  y
  }
  
  return(max.value)
}
mymax(-1, 10)

# 사용자 정의 함수에서도 매개변수의 초기값을 설정할 수 있음
# 두 개의 값(x,y)을 입력받아 x/y 값을 반환하는 함수
# (단, y의 초기값은 1)
mydiv <- function(x, y=2) {
  return(x/y)
}

mydiv(10, 3)   # mydiv(x = 10, y = 3) 이렇게 해도 됨
mydiv(10)      # y의 초기값 설정되어있으니까 10/2 출력
mydiv(y=10)    # x 없어서 에러남


# 여러 개의 값을 반환해야 하는 경우에는
# 리스트로 묶어 반환함
# 매개변수 x, y를 입력받아
# 두 변수의 합과 곱을 리스트로 반환하는 함수
myfunc <- function(x, y){
  sum.value <- x + y
  mul.value <- x * y
  
  return(list(sum = sum.value,
              mul = mul.value))
}

res <- myfunc(5,8)
res
res$sum
res$mul

unlist(res)
is(unlist(res))



















