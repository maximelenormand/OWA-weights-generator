library(shiny)
library(shinyWidgets)

# UI
shinyUI(navbarPage(title=HTML('<span style="font-size:120%;color:white;font-weight:bold;">Generating OWA weights using truncated distributions&nbsp;&nbsp;</span></a>'),
                   windowTitle="OWA weights generator",

  ##### Single weight generation #####################################################################################
  tabPanel(HTML('<span style="font-size:100%;color:white;font-weight:bold;">Single generation</span></a>'),                   
  
      # Include custom CSS & logo   
      tags$head(
        includeCSS("styles.css"),
        tags$link(rel = "icon", type = "image/png", href = "Logo.png") 
      ),
    
      #Panel 
      absolutePanel(id = "control", class = "panel panel-default", fixed = FALSE,
                    draggable = FALSE, top = 80, left = "auto", right = 20, bottom = "auto",
                    width = 360, height = "auto",
                    
        div(" ", style="height:5px;"),            
                    
        HTML('<div style="font-size:200%;color:#4682B4;">Risk & Tradeoff</div>'),            
       
        div(" ", style="height:10px;"), 
        
        chooseSliderSkin("Flat", "#4682B4"),
        #chooseSliderSkin("Flat"),
        #setSliderColor(rep("#4682B4",8), 1:8),
        sliderInput(inputId="nb_cri", 
                     label="Number of criteria", 
                     value=5, 
                     min = 2, 
                     max = 100, 
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
        
        plotOutput("para", height = 320, width=320)

      ),
      
      #Main panel (plot, warning, table and link to download table in csv)

        div(" ", style="height:0px;"),
        
        HTML(
          '<div style="max-width:900px; word-wrap:break-word;">
            <p style="font-size:120%;text-align:justify">
                  This interactive web application has been designed to provide an easy way to generate OWA weights 
                  according to a certain level of risk and trade-off using truncated distributions. 
                  More information are available in <a href="http://onlinelibrary.wiley.com/doi/10.1002/int.21963/full" target=_blank>this paper</a>.
                  A more elaborated tool designed to generate experimental designs is available in the next tab.
              </p>
          </div>'
        ), 
      
       div(" ", style="height:3px;"), 
      
        HTML(
          '<div style="max-width:900px; word-wrap:break-word;">
              <p style="font-size:120%;text-align:justify">
                  The source code is  available <a href="http://www.maximelenormand.com/Codes" target=_blank>here</a>.
                </p>
            </div>'
        ), 
        
        div(" ", style="height:10px;"), 
      
        HTML('<div style="font-size:130%;font-weight:bold;">Continuous distribution of order weights</div>'), 
      
        div(" ", style="height:10px;"), 
        
        plotOutput("f_w",
                   width="900px",
                   height="400px"),
        
        div(" ", style="height:5px;"), 
        
        htmlOutput("warning"),
        
        div(" ", style="height:5px;"),            
        
        HTML('<div style="font-size:130%;font-weight:bold;">Discrete distribution of order weights</div>'), 
        
        div(" ", style="height:5px;"), 
        
        tableOutput('table'),
        
        downloadButton('download_w', 'Download')

  ),
      
  ##### Experimental design #####################################################################################
  tabPanel(HTML('<span style="font-size:100%;color:white;font-weight:bold;">Experimental design</span></a>'),
           
        # Include custom CSS & logo   
        tags$head(
            includeCSS("styles.css"),
             tags$link(rel = "icon", type = "image/png", href = "Logo.png") 
        ),
        
        #Panels
        absolutePanel(id = "control1", class = "panel panel-default", fixed = FALSE,
                      draggable = FALSE, top = 60, left = 30, right = "auto", bottom = "auto",
                      width = 350, height = "820",

                      div(" ", style="height:10px;"),
                      
                      HTML('<div style="margin-left:-24px;font-size:130%;font-weight:bold;">1. Define your experimental design</div>'), 
                      
                      div(" ", style="height:10px;"), 
                      
                      selectInput("shape", 
                                  label=strong("Shape"), 
                                  choices=list("Parabolic" = "parabolic",
                                               "Circle" = "circle",
                                               "Square" = "square"),
                                  selected="circle"),
                      
                      sliderInput("centerx",
                                  label = "Center X", 
                                  value = 0.5, 
                                  min = 0, 
                                  max = 1,
                                  step=0.05), 
                      
                      sliderInput("centery",
                                  label = "Center Y", 
                                  value = 0.5, 
                                  min = 0, 
                                  max = 1,
                                  step=0.05), 
                      
                      sliderInput("radius",
                                  "Radius", 
                                  value = 0.2, 
                                  min = 0.01, 
                                  max = 1,
                                  step=0.01),
                      
                      div(" ", style="height:10px;"),
                      
                      HTML('<div style="margin-left:-24px;font-size:130%;font-weight:bold;">2. Generate your experimental design</div>'), 
                      
                      div(" ", style="height:10px;"),          

                      sliderInput("nbsim",
                                  label = "Number of simulations", 
                                  value = 1000, 
                                  min = 0, 
                                  max = 10000,
                                  step=10),
                      
                      div(" ", style="height:5px;"),
                      
                      uiOutput("run"),
                      tags$style(type='text/css', "#run {width:130px;float:left;}"),

                      div(" ", style="height:50px;"),
                      
                      HTML('<div style="margin-left:-24px;font-size:130%;font-weight:bold;">3. Choose the number of criteria</div>'), 
                      
                      div(" ", style="height:10px;"),             
                      
                      sliderInput(inputId="nbcri2", 
                                   label="Number of criteria", 
                                   value=5, 
                                   min = 2, 
                                   max = 100, 
                                   step = 1),
                      
                      div(" ", style="height:5px;"),
                      
                      uiOutput("run2"),
                      uiOutput("download"),
                      tags$style(type='text/css', "#run2 {width:130px;float:left;}"),
                      tags$style(type='text/css', "#output {width:130px;float:right;}")
        ),

        plotOutput("para2", height = 600, width=600),
        tags$style(type="text/css",
                   "#para2 img{display:block;margin-top:10%;margin-bottom:auto;margin-left:70%;margin-right:auto;}")
        
        
  )
  
))
