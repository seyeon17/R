library(tidyverse)
library(palmerpenguins)
library(babynames)
# (전 시간에 했던 거)
# 품종에 따른 체중에 대한 상자그림
# --- ㅣㅣㅣ
# 교재에는 ㅡㅡㅡ인데 여기서는 ㅣㅣㅣ로 할거야
penguins %>% 
  drop_na() %>% 
  ggplot(aes(x =species, y = body_mass_g)) +
  geom_boxplot(aes(fill= species), width = 0.5) + # width, 상자 날씬  
  geom_boxplot() +
  coord_flip()  # 이거 그냥 참고만 해라...

## 7.3.7. 선 그래프(line plot)

# 이름에 "x"가 포함되는 아기의 비율 변화 ← 연도별로 x가 포함된 비율
babynames %>% 
  group_by(year) %>% 
  summarise(prop_x = mean(str_detect(name, "x"))) %>% 
  ggplot(aes(x = year, y = prop_x)) +
  geom_line(size = 0.8, color = "forestgreen")

# 시간에 흐름에 따른 대륙별 기대 수명의 중앙값 변화
  # install gapminder
library(gapminder)
gapminder %>% 
  group_by(continent, year) %>% 
  summarise(lifeExp = median(lifeExp)) %>% 
  ggplot(aes(x = year, y = lifeExp, color = continent)) +
  geom_line(size = 1) +
  geom_point(size = 2.5, pch = 21, fill = "white") +
  scale_color_manual(values = wes_palette("Darjeeling1")) +
  theme_classic()

  # geom_point : 포인트 콕콕, 내부 색깔만 화이트로 바꿈
  # line이랑 point 순서 바꾸면 선이 포인트 덮어버림
 
library(wesanderson)

wes_palette("GrandBudapest1")

# 과제냈다.. 과제 불러와서 타이디하게 만들고,, 분석하고 시각화하고
# 관심잇는 주제 잡아서 데이터를 수집하고 분석하는 개인 프로젝트
# 결과 보고서를 만들어. R markdown 이용해서 html로 만들어
# r markdown은 시험에 안 나온다~ 데이터 수집 어떻게? 전처리와 분석 어떻게?
# 결과? pdac 사이클?을 이용해서 해라~ 서본결 순으로.
# 서론에 왜 내가 이 주제를 선정했는가 꼭 작성하고!
# 본론ㅇ에 데이터 수집 어떻게 했는지 출처
# 분석한거 설명 결과
# 최종적으로 이거 가지고 어떤 인사이트를 가질 수 있을 것인가..
# 분석하는 과정도 코드 다 잇어야댐!!
# 세개 제출해야돼 html, Rmd 파일, 데이터 파일(얘는 개수 제한 없어)




































