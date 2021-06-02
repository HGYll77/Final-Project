library(dplyr)
library(tidyverse)
library(ggplot2)
library(maps)

cases_data <- read.csv("../Data/Cases.csv", sep = ",") %>%
  group_by(County) %>%
  summarize()

county_data <- map_data("county") %>%
  filter(region == "washington")

county_map <- ggplot(county_data, aes(long, lat, group = group)) + 
  geom_polygon(col = 'black') + 
  labs(title = 'WA state counties map') +
  coord_quickmap()