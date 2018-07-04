library(shiny)

shinyUI(fluidPage(title="OWA weights generator",
  
  # Include custom CSS & logo   
  tags$head(
    includeCSS("styles.css"),
    tags$link(rel = "icon", type = "image/png", href = "Logo.png") 
  ),

  #Panel (n, risk and trade-off) + link to the GitHub repository
  absolutePanel(id = "control2", class = "panel panel-default", fixed = TRUE,
                draggable = FALSE, top = 20, left = "auto", right = 20, bottom = "auto",
                width = 360, height = "auto",
                
    div(" ", style="height:5px;"),            
                
    HTML('<div style="font-size:200%;color:#4682B4;">Risk & Tradeoff</div>'),            
   
    div(" ", style="height:10px;"), 
    
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
    
    p(strong("Parabolic decision-strategy space")),
    
    plotOutput("para", height = 320, width=320),
    
    p(strong("Source")),

    HTML('The source code is  available <a href="https://github.com/maximelenormand/OWA-weights-generator" target=_blank>here</a>.')
    
  ),
  
  #Main panel (plot, warning, table and link to download table in csv)
  mainPanel(
    
    div(" ", style="height:20px;"),
    
    div("Generating OWA weights using truncated distributions", 
        style="font-size: 25pt; line-height: 30pt; align='center';font-weight:bold;"
    ), 
    
    div(" ", style="height:30px;"), 
    
    plotOutput("f_w",
               width="900px",
               height="400px"),
    
    div(" ", style="height:5px;"), 
    
    htmlOutput("warning"),
    
    div(" ", style="height:5px;"),            
    
    HTML('<div style="font-size:130%;font-weight:bold;">Weights</div>'), 
    
    div(" ", style="height:5px;"), 
    
    tableOutput('table'),
    
    downloadButton('download_w', 'Download')
    
  )
  
))