library(shiny)

shinyUI(fluidPage(
  
  #Header panel   
  fluidRow(
    
    br(),
    column(width = 10, 
           style = "font-size: 25pt; line-height: 30pt; align='center'", 
           tags$strong("Generating OWA weights using truncated distributions"))
  ),
  
  br(),
  
  #Sidebar (n, risk and trade-off) + link to the GitHub repository
  sidebarPanel(
    
    numericInput(inputId="nb_cri", 
                 label="Number of Criteria", 
                 value=5, 
                 min = 2, 
                 max = 100000, 
                 step = 1),
    
    sliderInput("risk",
                label = "Risk", 
                value = 0.5, 
                min = 0, 
                max = 1,
                step=0.05), 

    sliderInput("tradeoff",
                "Tradeoff", 
                value = 0.5, 
                min = 0, 
                max = 1,
                step=0.05), 
    
    br(),
    
    htmlOutput("credit")
    
  ),
  
  #Main panel (plot, warning, table and link to download table in csv)
  mainPanel(
    
    plotOutput("f_w",
               width="900px",
               height="400px"),
    
    br(),
    
    htmlOutput("warning"),
    
    br(),
    
    tableOutput('table'),
    
    downloadButton('download_w', 'Download')
    
  )
  
))