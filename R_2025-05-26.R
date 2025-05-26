## 7.3. ggplot2 패키지
## 7.3.3. 막대 그래프
library(tidyverse)
diamonds

## Example 1: 컷 품질에 대한 막대그래프
ggplot(diamonds, aes(x = cut)) + geom_bar()
ggplot(diamonds, aes(x = cut)) + geom_bar(fill = "orange") # 칼라코드를 넣을 수도 있음
ggplot(diamonds, aes(x=cut, fill = cut)) + geom_bar() # 막대마다 색깔 다르게!

## Example 2: 컷 품질, 다이아몬드 투명도에 대한 막대그래프
p <- ggplot(diamonds, aes(x = cut, fill = clarity))
p + geom_bar()                    # 누적 막대그래프
p + geom_bar(position = "fill")   # 100% 누적 막대그래프
p + geom_bar(position = "dodge")  # 막대를 옆으로 나란히 하고 싶으면 이렇게!


## Example
mytbl <- tibble(group = factor(c("A", "B", "C")),
                freq = c(20, 15, 30))

mytbl

diamonds %>% count(cut)
ggplot(mytbl, aes(x = group, y = freq)) + 
  geom_bar(stat = "identity")

# y축 x축 자리를 바꾸고 싶으면
# x, y 자리만 바꿔줌

diamonds %>% count(cut)
ggplot(mytbl, aes(y = group, x = freq)) + 
  geom_bar(stat = "identity")

# 막대그래프 저장하고 싶으면 plots의 Export 누르면 됨
## Example 3
# 인종의 빈도가 큰 순서대로 시각화
ggplot(gss_cat, aes(x = race)) + geom_bar()
gss_cat$ race %>%  levels

# RColorBrewer 인스톨 하셈
library(RColorBrewer)

gss_cat %>% 
  mutate(race = fct_infreq(race)) %>% 
  ggplot(aes(x=race, fill = race)) +
  geom_bar() +
  # 관측값이 없는 수준도 표시하고 싶음
  scale_x_discrete(drop = FALSE) +
  scale_fill_manual(values = brewer.pal(4,"Spectral")) +
  labs(x = "", y = "Frequency") +
  theme(axis.title.y = element_text(size = 20, margin = margin(r=15)),
        axis.text = element_text(size = 15),
        legend.position = "none") 


## Example 4

## 7.3.4. 히스토그램
PlantGrowth

ggplot(PlantGrowth, aes(x = weight)) + 
  geom_histogram(fill = "steelblue", bins = 10) +
  labs(title = "Histogram of the dried weight of plants", 
       x = "Weight", y = "") + 
  theme_classic()  # <- 배경. theme_()


## Example 2
# 처리 집단에 따른 건조 중량의 분포 비교
labels <- c("ctrl" = "대조군", "trt1" = "실험군A", "trt2" = "실험군B")

ggplot(PlantGrowth, aes(x = weight, fill = group)) +
  geom_histogram(binwidth = 0.5) + 
  labs(title="Histogram of the dried weight of plants", x = "Weight", y ="") +
  facet_grid(group ~ ., labeller = labeller(group =labels)) +
  theme(plot.title = element_text(size = 25, hjust = 0.5),
        axis.title = element_text(size = 15),
        axis.text = element_text(size = 15),
        strip.text = element_text(size = 20, face = "bold"), # 볼드 체
        legend.position = "none")




## 7.3.5. 상자 그림(box plot)
# install permerpenguins

library(palmerpenguins)
penguins

## Example 0
# 체줄에 대한 상자그림
penguins %>% 
  drop_na() %>% # 결측값 지우기
  ggplot(aes(y = body_mass_g)) +
  geom_boxplot()

# 오른쪽으로 꼬리가 긴 분포.





