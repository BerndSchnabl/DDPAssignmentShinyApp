library(shiny)
library(markdown)

colnames <- names(mtcars)


po <- mainPanel(
  
  plotOutput('regressionsplot'),
  verbatimTextOutput('fit')
  
  )

shinyUI(
  
  pageWithSidebar(

    headerPanel('MT Cars Analysis'),
  
    ## ---------------------------------------------------------------------
    ## input in left panel
    ## ---------------------------------------------------------------------
    sidebarPanel(
     selectInput('x', 'X', colnames),
     selectInput('y', 'Y', colnames, selected=colnames[[2]]),
     sliderInput('number','Number', 2,min=1, max=10)
    ),

    ## ---------------------------------------------------------------------
    ## layout for mainpanel
    ## ---------------------------------------------------------------------
    mainPanel( 
      tabsetPanel(
        type = 'tabs', 
        tabPanel('Plot',         plotOutput('kmeansplot')),
        tabPanel('Regression',   po),
        tabPanel('Instructions', mainPanel(includeMarkdown('about.md')))
      ) ## end of tabset
    ) ## end of mainpanel     
  ) ## end of pageWithSidebar
) ## end of ShinyUI
