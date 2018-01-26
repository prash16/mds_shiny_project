
#


shinyServer(function(input, output,session) {
  
  table2<-reactive({
    marshall_w %>%
      filter(year >= input$year[1],
             year <= input$year[2],
             department_name %in% c(input$dep, input$dep1)) %>% 
        select(year,department_name, homs_sum, rape_sum ,rob_sum ,agg_ass_sum, violent_crime,pop) %>% 
      rename(Year=year,City=department_name,Population=pop,Homicides=homs_sum,Rapes=rape_sum,
             Robbery=rob_sum,AggrevatedAssaults=agg_ass_sum)  

  })
  
  activeTab <- reactive({input$tabs})
  
  output$dep <- renderUI({
    if (activeTab() != 'Regions') {
      selectInput("dep","Cities",unique(marshall$department_name),selected = "Cities") 
    }
  })
  
  output$dep1 <- renderUI({
    if (activeTab() != 'Regions') {
      selectInput("dep1","Comparing Cities",unique(marshall$department_name),
                  selected = "Cities")
    }
  })
  
  
  output$distPlot <- renderPlotly({
    
    if (is.null(input$dep) | is.null(input$dep1)) {
      return(NULL)
    }
    
    response_variable = input$crime
    
    ### code starts here 
    
    
    p <- marshall_w%>% 
      filter(year >= input$year[1], year <= input$year[2],
             department_name %in% c(input$dep, input$dep1)) %>% 
      ggplot(aes_string("x=year",y=response_variable))+
      geom_line(aes(colour=department_name),size=1)+theme_bw()+
      labs(color = "Department",x = "year",
           # Name the y-axis/title based on input from input$crime/input$scale from ui.R
           y = paste(names(crimesgroup[crimesgroup == input$crime])))
    
    #if (input$avg) {geom_line(data=marshall_w%>% filter(department_name == "National"),aes_string("x=year", y=response_variable))}
    
    p <- ggplotly(p)
    
    ###code ends here 
    
    
  })
  
  
  ###second plot here 
  
  
  output$barplot <- renderPlotly({
    response_variable = input$crime
    
    p1 <- marshall_w %>%  
      filter(year >= input$year[1], year <= input$year[2],
             department_name %in% c(input$dep, input$dep1)) %>% 
      ggplot(aes_string("x=year", y=response_variable, fill="department_name")) +
      geom_bar(stat="identity") +
      labs(fill = "Area", x="year", y="crimes")+theme(axis.line = element_line(colour = "black"),
      panel.border = element_blank(), panel.background = element_blank())
    p1 <- ggplotly(p1)
    ###code ends here 
  })



  
  ### Boxplot lives here 
  
  output$boxplot <- renderPlotly({
new_data1 %>% 
  filter(year >= input$year[1], year <= input$year[2],coast %in% input$usregions) %>% 
  plot_ly( y = ~get(input$crime), color = ~coast, type = "box") 
  })  
  
### Box plot ends here 
  
# Line plot for regions ####
  output$lineplotus <- renderPlotly({ 
  new_data1 %>% 
    filter(year >= input$year[1], year <= input$year[2],
           coast %in% input$usregions) %>% 
    plot_ly(x = ~year, y =   ~get(input$crime) , type = 'scatter', 
            mode = "lines+markers", split = ~coast,  text = ~paste("Total Crime In "))
  })  
  

  
  #~coast
# Render table #### in page 3 
  
  output$Crimeresults <- renderDataTable({
    table2()
  }) 

### render table code ends 
    
  
## render table , pushed in milestone 2, not using anymore ###


  output$Crimeresults <- renderDataTable({
    table2()
  })
  
  

  
  output$results <- renderTable(width = "800",{
    filtered <-
      marshall_w %>%
      filter(year >= input$year[1],
             year <= input$year[2],
             department_name %in% c(input$dep, input$dep1)) %>% 
      select(year,department_name,total_pop,crimesgroup) %>% 
      rename(Year=year,City=department_name,Population=total_pop,Homicides=homs_per_100k,Rapes=rape_per_100k,
             Robbery=rob_per_100k,TotalCrime=tot100k,AggrevatedAssaults=agg_ass_per_100k)
    
    filtered 
  })
  
})

tabsetPanel(position = "below",
            tabPanel("Plot", plotOutput("plot")), 
            tabPanel("Summary", verbatimTextOutput("summary")), 
            tabPanel("Table", tableOutput("table"))
)

