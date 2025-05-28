## chapter 7. ggplot2 패키지
## 7.3.5. 상자그림

library(tidyverse)
library(palmerpenguins)

# 품종에 따른 체중에 대한 상자그림
# --- ㅣㅣㅣ
# 교재에는 ㅡㅡㅡ인데 여기서는 ㅣㅣㅣ로 할거야
penguins %>% 
  drop_na() %>% 
  ggplot(aes(x =species, y = body_mass_g)) +
  geom_boxplot(aes(fill= species), width = 0.5) + # width, 상자 날씬  
  geom_boxplot() +
  coord_flip() +
  labs(title="Boxplot of Body Mass by Species", x = "", y ="Weight (g)") +
  theme_classic() +
  theme(plot.title = element_text(size = 20, margin = margin(b=10)),
        axis.title.x = element_text(size = 15, margin = margin(t=10)),
        axis.text = element_text(size = 12),
        legend.position.inside = )


# 서식지, 품종, 성별에 따른 체중 분포 비교
pg <- penguins %>% 
  drop_na() %>%
  ggplot(aes(x = island, y = body_mass_g)) +
  geom_boxplot() +
  facet_grid(sex ~ species) +
  labs(x = "", y ="Weight (g)") +
  theme_bw() +
  theme(axis.title.y = element_text(size = 15, margin = margin(r=10)),
        axis.text = element_text(size = 12),
        strip.text =  element_text(size = 15, face="bold"),
        legend.position = "none",
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank())

pg

   # 아델라이는 세 섬에 다 사는데 친스트랩은 드림에만 살고 젠투는 토저센에만 삼
   # 몸무게에 영향을 주는 건 Species구나

pg + geom_point(color = "steelblue", alpha = 0.5)               # 상자그림 위에 점 찍음
pg + geom_jitter(color = "steelblue", alpha = 0.5, width = 0.2) # 흩어지게


## 7.3.6. 산점도(scatter plot)
# Example 1
# 지느러미 길이와 체중에 대한 산점도 및 회귀선
penguins %>% 
  drop_na() %>% 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(size = 4, color = "forestgreen", pch = 17, alpha = 0.5) +
  geom_smooth(method = lm, color = "red") +
  geom_rug() +
  theme_classic()

# 강한 양의 상관관계
# 지느러미 너비가 1mm 증가할수록 체중은 5.015g 증가함
# geom_smooth <- 회귀선 구하는 거
# theme_classic() <- 신뢰구간
# geom_rug <- 러그 털달린 거처럼

model <- lm(body_mass_g ~ flipper_length_mm, data = myp)
summary(model)
# 상관관계 봐보자
myp <- penguins %>% drop_na()
cor(myp$flipper_length_mm, myp$body_mass_g)
# 0. 87 -> 매우 강한 상관관계




# Example 2
# 지느러미 길이와 체중에 대한 산점도 + 품종(색상, 모양)
penguins %>% 
  drop_na() %>% 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, pch = species), size = 4)



# 지느러미 길이와 체중에 대한 산점도 + 부리 길이(색상 (연속적임..))

penguins %>% 
  drop_na() %>% 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = bill_length_mm, pch = species), size = 4) +
  scale_color_gradient(low = "red", high = "blue")


# 지느러미 길이와 체중에 대한 산점도 +
# 부리 길이(크기), 성별(색상)


penguins %>%
  drop_na() %>% 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = sex, size = bill_length_mm))









