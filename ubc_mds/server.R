



shinyServer(function(input, output,session) {
  
  table2<-reactive({
    marshall_w %>%
      filter(year >= input$year[1],
             year <= input$year[2],
             department_name %in% c(input$dep, input$dep1)) %>% 
      select(year,department_name,total_pop,crimesgroup) %>% 
      rename(Year=year,City=department_name,Population=total_pop,Homicides=homs_per_100k,Rapes=rape_per_100k,
             Robbery=rob_per_100k,TotalCrime=tot100k,AggrevatedAssaults=agg_ass_per_100k)  
  })
  
  
  
  output$distPlot <- renderPlotly({
    
    
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
    
    
    
    # theme(axis.line = element_line(colour = "black"),
    # panel.border = element_blank(),
    #    panel.background = element_blank())+
    # ggtitle(paste(input$crime,"Per 100k People","in",input$dep,"and",input$dep1,"from",input$year[1],"to",input$year[2]))
    
    
    #if (input$avg) {geom_line(data=marshall_w%>% filter(department_name == "National"),aes_string("x=year", y=response_variable))}
    
    
    p <- ggplotly(p)
    
    ###code ends here 
    
    
  })
  
  
  ###second plot here 
  
  
  output$barplot <- renderPlotly({
    response_variable = input$crime
    
    ### code starts here 
    
    #g <- ggplot(mpg, aes(class))
    # x <- g + geom_bar()
    
    
    #ggplotly(x)
    #png(filename="bench_query_sort.png", width=800, height=600)
    p1 <- marshall_w %>%  
      filter(year >= input$year[1], year <= input$year[2],
             department_name %in% c(input$dep, input$dep1)) %>% 
      ggplot(aes_string("x=year", y=response_variable, fill="department_name")) +
      geom_bar(stat="identity") +
      labs(fill = "Area", x="year", y="crimes")+theme(axis.line = element_line(colour = "black"),
                                                      panel.border = element_blank(),
                                                      panel.background = element_blank())
    p1 <- ggplotly(p1)
    ###code ends here 
  })
  

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


