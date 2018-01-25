#Libraries 

library(shiny)
library(ggplot2)
library(dplyr)
library(colourpicker)
library(shinythemes)
library(tidyverse)
library(plotly)
library(DT)

#reading the data set 

marshall <- read_csv("ucr_crime_1975_2015.csv")

marshall_filter <- read_csv("filter.csv")

#Wrangling
marshall_w <- marshall %>%
  #mutate(tot100k = violent_per_100k +homs_per_100k+rape_per_100k+rob_per_100k+agg_ass_per_100k) %>% 
  select(year,department_name,homs_sum,rape_sum,rob_sum,agg_ass_sum,violent_crime,total_pop,
         violent_per_100k,homs_per_100k,rape_per_100k,rob_per_100k,agg_ass_per_100k) 

## More wrangling 

marshall_states <- marshall_filter %>% 
  # select(region,code,year) %>% 
  group_by(region,code) %>% summarise()



states <- read_csv("states.csv")


new_data <- left_join(marshall_filter,states,by="code")

new_data1 <- new_data %>% group_by(coast, year,coast) %>% 
summarise(pop = sum(total_pop, na.rm = TRUE),
          rape = sum(rape_per_100k, na.rm = TRUE),
          assault = sum(agg_ass_per_100k, na.rm = TRUE),
          robbery = sum(rob_per_100k, na.rm = TRUE),
          homicide = sum(homs_per_100k, na.rm = TRUE),
          violent = sum(violent_per_100k, na.rm = TRUE))

# crime choice for sum more wrangling

colnames(marshall_w)[8:13] <- c("pop", "violent", "homicide", "rape", "robbery", "assault")


crimesgroup <- c(#"All Crime" = colnames(marshall_w)[8],
  "All Crime" = colnames(marshall_w)[9],
  "Homicides" = colnames(marshall_w)[10],
  "Rapes" = colnames(marshall_w)[11],
  "Robberies" = colnames(marshall_w)[12],
  "Aggrevated Assaults" = colnames(marshall_w)[13])

