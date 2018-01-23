

#Libraries 
library(shiny)
library(colourpicker)
library(shinythemes)
library(ggthemes)

# Main Shiny page 
shinyUI(fluidPage(theme = shinytheme("cosmo"),
        br(),
       titlePanel("Crime app"),
     # Slide bar layout       
       sidebarLayout(
                    sidebarPanel(
                      h4("Year"),
                      sliderInput('year', 'Year Range', 
                                  min=1975, max=2015, value=c(1975, 2007), 
                                  step=5, sep=""),
                      br(),
                      selectInput("dep","Cities",unique(marshall$department_name),selected = "Cities"),
                      selectInput("dep1","Comparing Cities",unique(marshall$department_name),
                                  selected = "Cities"),
                      
                      #h3("Labels"),
                      #checkboxInput("scale", "Labels", value = FALSE),
                      selectInput("crime","Type of Crime",crimesgroup)
                    ),
                    
                    
                    mainPanel( tabsetPanel(
                      tabPanel("Plot", plotlyOutput("distPlot"),
                               br(), br(),
                               tableOutput("results")), # first tab 
                      tabPanel("Plot2", plotlyOutput("barplot")), 
                      
                      tabPanel("Data",  DT::dataTableOutput("Crimeresults")
                      )
                    )  # Inputs excluded for brevity
                    )
                    
                  )
))