

#Libraries 
library(shiny)
library(colourpicker)
library(shinythemes)
library(ggthemes)

<<<<<<< HEAD
shinyUI(fluidPage(theme = shinytheme("cosmo"),
             
                  titlePanel("Crime app"),
                  
                  sidebarLayout(
                    
=======
# Main Shiny page 
shinyUI(fluidPage(theme = shinytheme("cosmo"),
        br(),
       titlePanel("Crime app"),
     # Slide bar layout       
       sidebarLayout(
>>>>>>> cb9a8190131214fb728ce6b99c16650a22ed35f3
                    sidebarPanel(
                      
                      checkboxGroupInput("usregions", h3("US Regions"),
                                   choices = list("North East" = "NORTHEAST", "Mid West" = "lifeExp","South"="gdpPercap",
                                                  "West"="WEST" ),selected = "lifeExp"),
                      selectInput("crime","Type of Crime",crimesgroup),
                      h4("Year"),
                      sliderInput('year', 'Year Range', 
                                  min=1975, max=2015, value=c(1975, 2007), 
                                  step=5, sep=""),
                      br(),
                      selectInput("dep","Cities",unique(marshall$department_name),selected = "Cities"),
                      selectInput("dep1","Comparing Cities",unique(marshall$department_name),
                                  selected = "Cities"),
                      
<<<<<<< HEAD
                      h3("National Average"),
                      checkboxInput("scale", "Labels", value = FALSE)
                    ),
                    mainPanel( tabsetPanel(
                      tabPanel("Regions", plotlyOutput("lineplotus"),
                               plotlyOutput("boxplot")),
                               
                               
                               #tableOutput("results")), # first tab 
                      
                      
                      tabPanel("City Specific", plotlyOutput("distPlot"),
                               plotlyOutput("barplot")), 
                      
                      tabPanel("Data",  DT::dataTableOutput("Crimeresults")
                      )
                    )  
=======
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
>>>>>>> cb9a8190131214fb728ce6b99c16650a22ed35f3
                    )
                    
                  )
))