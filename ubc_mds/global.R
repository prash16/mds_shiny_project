#Libraries 

library(shiny)
library(ggplot2)
library(dplyr)
library(colourpicker)
library(shinythemes)
library(tidyverse)
library(plotly)
library(DT)
library(devtools)

#reading the data set 

marshall <- read_csv("ucr_crime_1975_2015.csv")

#Wrangling
marshall_w <- marshall %>%
  mutate(tot100k = violent_per_100k +homs_per_100k+rape_per_100k+rob_per_100k+agg_ass_per_100k) %>% 
  select(year,department_name,total_pop,homs_sum,rape_sum,rob_sum,agg_ass_sum,violent_crime,
         violent_per_100k,homs_per_100k,rape_per_100k,rob_per_100k,agg_ass_per_100k,tot100k) 



# crime choice for sum more wrangling

crimesgroup <- c(#"All Crime" = colnames(marshall_w)[8],
  "All Crime" = colnames(marshall_w)[14],
  "Homicides" = colnames(marshall_w)[10],
  "Rapes" = colnames(marshall_w)[11],
  "Robberies" = colnames(marshall_w)[12],
  "Aggrevated Assaults" = colnames(marshall_w)[13])

