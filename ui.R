library(shiny)
Sys.setlocale(locale="C")
shinyUI(fluidPage(
    titlePanel(h2("IIT Roorkee Placement Details for Session 2013-14 and 2014-15",align = "center")),
    sidebarLayout(
        sidebarPanel(
           radioButtons("yr","Select the placement Session", list("2013-14","2014-15")),
            br(),
            uiOutput("number"),
            br(),
            uiOutput("br"),
            br(),
            uiOutput("dr"),
            actionButton("action","Submit"),
            br(),
            helpText("Select the download format"),
           radioButtons("type", "Format type:",
                        choices = c("Excel (CSV)", "Text (TSV)","Text (Space Separated)", "Doc")),
           downloadButton("download","Download the table")
           ),
       mainPanel(
           tableOutput("data")
           
         
       )
    )
)
    
)