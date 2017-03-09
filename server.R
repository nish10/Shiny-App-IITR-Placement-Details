library(shiny)
library(rdrop2)

placement<- drop_read_csv("mydata.csv", header = TRUE)
placement$Degree <- as.character(placement$Degree)
placement$Branch <- as.character(placement$Branch)
placement$Companies <- as.character(placement$Companies)

shinyServer(function(input,output){
    
    var<- reactive({
        switch(input$yr,
               "2013-14" = 2014,
               "2014-15" = 2015
               )

    })
    year<- reactive({
    unique(subset(placement, Year==var(), select = Branch))
    unique(subset(placement, Year==var(), select = Branch))
    
    })
    
    output$number<- renderUI({
        p(paste("Data available for the no. of branches in the selected session is ", nrow(year())))
    })
    
    output$br<- renderUI({
        selectInput("X", "Select the branch", choices= year())
    })
  
    deg<- reactive({
        unique(subset(placement, Branch == input$X, select = Degree))[[1]]
    })
    
    
    output$dr<- renderUI({
        selectInput("Y", "Select the degree", choices = deg())
    })
    
    output$data<- renderTable({
        input$action
        isolate(subset(placement, Year==var() & Branch == input$X & Degree == input$Y))
    })
    
    df<- reactive({
      subset(placement, Year==var() & Branch == input$X & Degree == input$Y)
    })

    fileext <- reactive({
      switch(input$type,
             "Excel (CSV)" = "csv", "Text (TSV)" = "txt","Text (Space Separated)" = "txt", "Doc" = "doc")
      
    })
    
    output$download <- downloadHandler(
      
    
      filename = function() {
        paste(Sys.time(),"_IITR_placement",".",fileext(), sep = "")
        
      },
      content = function(file) {
        sep <- switch(input$type, "Excel (CSV)" = ",", "Text (TSV)" = "\t","Text (Space Separated)" = " ", "Doc" = " ")
        
        write.table(df(), file, sep = sep,
                    row.names = FALSE)
      }
    )
        
})      
     
 
    
    
    
    
