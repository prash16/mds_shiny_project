library(shiny)
library(ggplot2)
library(dplyr)
library(devtools)
library(colourpicker)
library(shinythemes)
library(ggthemes)

shinyUI(fluidPage(theme = shinytheme("cosmo"),
             
                  titlePanel("Crime app"),
                  
                  sidebarLayout(
                    
                    sidebarPanel(
                      
                      checkboxGroupInput("usregions", h3("US Regions"),
                                   choices = list("North East" = "NORTHEAST", "Mid West" = "MIDWEST","South"="SOUTH",
                                                  "West"="WEST" ),selected = c("NORTHEAST","MIDWEST","SOUTH","WEST")),
                      selectInput("crime","Type of Crime",crimesgroup),
                      h4("Year"),
                      sliderInput('year', 'Year Range', 
                                  min=1975, max=2015, value=c(1975, 2007), 
                                  step=5, sep=""),
                      br(),
                      uiOutput("dep"),
                      uiOutput("dep1")
                      ),
                      # selectInput("dep","Cities",unique(marshall$department_name),selected = "Cities"),
                      # selectInput("dep1","Comparing Cities",unique(marshall$department_name),
                      #             selected = "Cities")),
                      
                     # h3("National Average"),
                     # checkboxInput("scale", "Labels", value = FALSE)
                    #),
                    
                    mainPanel(tabsetPanel(id="tabs",
                      tabPanel("Regions", plotlyOutput("lineplotus"),
                               plotlyOutput("boxplot")),
                               
                               
                               #tableOutput("results")), # first tab 
                      
                      tabPanel("City Specific", plotlyOutput("distPlot")),
                              ## plotlyOutput("barplot")), 
                      
              tabPanel("Data",  DT::dataTableOutput("Crimeresults") ) ) ) )
))