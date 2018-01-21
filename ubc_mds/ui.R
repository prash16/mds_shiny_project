library(shiny)
library(ggplot2)
library(dplyr)
library(devtools)
library(colourpicker)
library(shinythemes)



shinyUI(fluidPage(theme = shinytheme("cosmo"),
                  
                  br(),
                  titlePanel("Tabsets"),
                  
                  sidebarLayout(
                    
                    sidebarPanel(
                      h4("Year"),
                      sliderInput('year', 'Year Range', 
                                  min=1975, max=2015, value=c(1975, 2007), 
                                  step=5, sep=""),
                      br(),
                      selectInput("dep","Cities",unique(marshall$department_name),selected = "Cities"),
                      selectInput("crime","Type of Crime",crimesgroup),
                      selectInput("dep1","Comparing Cities",unique(marshall$department_name),
                                  selected = "Cities")),
                    
                    
                    mainPanel( tabsetPanel(
                      tabPanel("Plot", plotlyOutput("distPlot"),
                               br(), br(),
                               tableOutput("results")), # first tab 
                      
                      
                      tabPanel("Plot2", plotlyOutput("barplot")), 
                      tabPanel("Analysis", tableOutput("table"))
                    )
                    )  # Inputs excluded for brevity
                  )
                  
)
)
