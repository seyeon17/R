## 6.4.4.4 str_extract(), str_extract_all() 함수
library(tidyverse)

# 문장 데이터에서 색상 텍스트 추출
sentences
color <- c("^red$", "orange", "yellow", "green", "blue", "purple")

# 색상 벡터에서 하나의 정규 표현식으로 변환
color_match <- str_c(color, collapse = "|")  

# 색상을 포함하는 문장 추출
has_color <- str_subset(sentences, color_match)

# 일치하는 텍스트 추출
# str_extract() 함수는 처음 일치하는 패턴만 추출
str_extract(has_color, color_match)

# str_extract_all() 함수는 모든 일치하는 패턴을 추출 
# 리스트 반환
more <- sentences[str_count(sentences, color_match) > 1]
str_view(more, color_match)
str_extract(more, color_match)
str_extract_all(more, color_match)

# 행렬로 반환
str_extract_all(more, color_match, simplify = T)
str_extract_all(has_color, color_match, simplify = T)


## 6.4.4.5 str_replace(), str_replace_all() 함수
x <- c("apple", "banana", "pear")
str_replace(x, "[aeiou]", "-") # 처음 모음만 -
str_replace_all(x, "[aeiou]", "-") # 자음만 남고 모음은 다 -됨

# 벡터를 이용해서 여러 패턴을 한 번에 변경 가능
x <- c("1 house", "2 cars", "3 people")
str_replace_all(x, c("1"= "one", "2" = "two", "3" = "three"))


## 6.4.4.6 str_split() 함수
sentences %>%  head(5) %>% str_split(" ") # 딘어별 분할, 리스트 형태
sentences %>%  head(5) %>% str_split(" ", simplify = TRUE) # 딘어별 분할, 행렬 형태


x <- "This is sentence. This is another sentence."
str_view(x, boundary("word"))
str_view(x, boundary("sentence"))
str_view(x, boundary("line_break")) # 줄을 바꿔 쓸 수 있는 포인트 
str_view(x, boundary("character"))

## 6.5. forcats 패키지
## forcats 패키지 소개
gss_cat 


## 6.5.2 팩터 수준(levels) 재정렬
fct1 <-  factor(c("b", "b", "a", "c", "c", "c"))
fct1

# levels을 처음 나타나는 순서대로 재정렬
# Levels: b a c
fct_inorder(fct1) 

# 각 수준의 빈도가 큰 순서대로 재정렬
# Levels : c b a
table(fct1)
fct_infreq(fct1)

# 수준의 수치 값(numeric value) 순서대로 재정렬
fct2 <- factor(1:3, levels = c("2", "3", "1"))
fct_inseq(fct2)

# 팩터 수준을 반대로 재정렬
fct_rev(fct1)
fct_rev(fct2)

# 결혼 상태에서 수준을 각 수준의 빈도에 대해 오름차순 재정렬
gss_cat %>% 
  mutate(marital = marital %>% fct_infreq() %>% fct_rev) %>% 
  ggplot(aes(marital)) + geom_bar
