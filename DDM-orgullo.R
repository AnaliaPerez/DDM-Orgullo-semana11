#Hecho por Analía Perez, el día 20/6/19, para datos de miércoles  

library(readr)
library(tidyverse)
library(wordcloud2)

leyes <- readr::read_csv("https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2019/2019-06-19/leyes.csv")

criminalizacionFreq <- leyes %>% 
  filter(criminalizacion==0) %>%
  select(pais_es, criminalizacion_pena) %>% 
  mutate(criminalizacion_pena= recode(criminalizacion_pena, "muerte (NOT)"= "22", "muerte (REG)"= "22", "muerte"= "22", "perpetua"= "21", "indeterminado"= "7")) %>% 
  mutate(criminalizacion_pena=as.integer(criminalizacion_pena)) %>% 
  rename(word= pais_es, freq=criminalizacion_pena) %>% 
  mutate(color = case_when(freq==22 ~ "red",
                           freq==21 ~ "black",
                           freq <21 ~ "#003366"))
                        

wordcloud2(criminalizacionFreq,
           color = criminalizacionFreq$color, size = .1, rotateRatio = 0, gridSize = 1)
