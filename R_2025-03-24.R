## Date: 2025-03-24
## chapter 3. 데이터와 자료구조


## 3.4. 행렬과 배열
## 3.4.6. 행렬 결합
m4 <- matrix(1:12, nrow = 4)  #4x3
m5 <- matrix(13:18, nrow = 2) #2x3
m6 <-  rbind(m4, m5)

v <- 1:6
m7 <- cbind(m6, v)
colnames(m7) <- NULL
m7


## 3.4.7. 배열 생성
arr <- array(1:12, dim = c(2,2,3))
arr

## 3.5. 리스트
## 3.5.1. 리스트 생성
myinfo <- list(name = "Kim",
               age = 25,
               smoking = TRUE,
               score = c(70, 85, 90))
list("kim", 25, TRUE, c(70, 85,90))

# 3.5.2. 리스트 인덱싱
myinfo$name
myinfo$score[1]
is(myinfo[[2]])
is(myinfo[2])


## 3.6. 데이터프레임
## 3.6.1. 데이터프레임 생성
df1 <- data.frame(name = c("Kim","Lee","Park","Choi"),
                  age = c(23,25,26,27),
                  btype = factor(c("A", "B", "O", "B")),
                  smoking = c(TRUE, FALSE, TRUE, TRUE))
df1

# data.frame(df1,
           pet= c("dog","cat","bird","dog"))
df2 <- cbind(df1,  c("dog","cat","bird","dog"))
colnames(df2)[5] <- "pet"
df2


## 3.6.2 데이터프레임 인덱싱
df2[1, 2]                                   # 1행 2열에 위치한 값 24
df2[, 3]                                    # 3열(btype)에 있는 모든 값
df2[4,]

df2[,1:3]
df2[,"name"]
df2[,c("name","age")]
df2[1:2, 3:4]

df2$smoking



### 3.6.3. 데이터프레임 요약 함수
iris
head(iris) # 헤드를 쓰면 첫번째부터 여섯번째 행까지 보여줌.
tail(iris) # 테일 쓰면 밑에있는 6개
str(iris) 

dim(iris)
nrow(iris)
ncol(iris)

unique(iris[,5]) # 품종이 세종류구나~ 
table(iris[,"Species"])

colMeans(iris[,-5]) # 각 열별로 평균이 나옴.
colSums(iris[,-5])  # 각 열별 합계!

rowMeans(iris[,-5])
rowSums(iris[,-5]) 




## chapter 4. 프로그래밍 구조
## 4.2. 조건문
## 4.2.1. if 문

# 시험 점수가 80점 이상이면 합격(Pass) 출력
score <- 85
result <- c() # 요거 추가
if(score >= 80)   { 
  print("Pass")}

## 4.2.2. if-else 문
# 시험 점수가 80점 이상이면 합격(Pass) 출력
# 80점 미만이면 불합격(Fail) 출력
score <- 

if(score >= 80)  {
  print("Pass")
} else {
  print("Fail")}

if(score >= 80)  {
  print("Pass")
} else { print("Fail")}


if(score >= 80)  {
  print("Pass")
} else { 
  print("Fail")}

## 4.2.3. ifelse() 함수
# 엑셀의 if 함수와 동일
score <- 85
result <- ifelse(score >= 85, "Pass", "Fail")

result

## 4.2.4. else if 문
# 시험 점수가 90점 이상이면 A학점, 
# 80~90점 미만이면 B학점,
# 70~80점 미만이면 C학점, 
# 60~70점 미만이면 D학점,
# 60점 미만이면 F학점 출력
score <- 85

if(score >= 90){
  grade <- "A"
} else if(score >= 80){
  grade <- 'B'
} else if(score >= 70) { 
  grade <- 'C'
} else if(score >= 60) { 
  grade <- 'D' 
} else { 
  grade <- 'F' 
}

grade








































