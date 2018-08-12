## app.R ##
library(shinydashboard)

sidebar <- dashboardSidebar(
  hr(),
  sidebarMenu(id="tabs",
              menuItem("Plot", tabName="plot", icon=icon("line-chart"), selected=TRUE),
              menuItem("Table", tabName = "table", icon=icon("table")),
              menuItem("Codes",  icon = icon("file-text-o"),
                       menuSubItem("Mlxtran", tabName = "pkmodel", icon = icon("angle-right")),
                       menuSubItem("ui.R", tabName = "ui", icon = icon("angle-right"))
              ),
              menuItem("ReadMe", tabName = "readme", icon=icon("mortar-board")),
              menuItem("About", tabName = "about", icon = icon("question"))
  ),
  hr(),
  conditionalPanel("input.tabs=='plot'",
                   fluidRow(
                     column(1),
                     column(10,
                            checkboxInput("first", "First order", TRUE)
                     )
                   )
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "readme",
            withMathJax()
            
    ),
    tabItem(tabName = "plot",
            fluidRow(
              column(width = 4, 
                     tabBox( width = NULL,
                             tabPanel(h5("parameters"),
                                      conditionalPanel(condition="input.first=='1' | input.alpha=='1' ",
                                                       sliderInput("ka", "ka:", value = 0.5, min = 0.1, max = 3, step=0.1)
                                      ),
                                      sliderInput("k", "k:", value = 0.1, min = 0, max = 2, step=0.05)
                             ),
                             tabPanel(h5("dosage"),
                                      sliderInput("tfd", "Time of first dose:", value=0, min=0, max = 20, step=1),
                                      sliderInput("nd", "Number of doses:", value=1, min=0, max = 10, step=1),
                                      sliderInput("ii", "Interdose interval:", value = 9, min = 0.5, max = 15, step=0.5),
                                      sliderInput("amt", "Amount:", value = 5, min = 0, max = 20, step=1)
                             )
                     )),
              column(width = 8,
                     box(  width = NULL, plotOutput("plot",height="500px"), collapsible = TRUE,
                           title = "Plot", status = "primary", solidHeader = TRUE)
              ))
    ),
    tabItem(tabName = "table",
            box( width = NULL, status = "primary", solidHeader = TRUE, title="Table",                
                 downloadButton('downloadTable', 'Download'),
                 br(),br(),
                 tableOutput("table")
            )
    ),
    tabItem(tabName = "pkmodel",
            box( width = NULL, status = "primary", solidHeader = TRUE, title="absorptionModel.txt",                
                 downloadButton('downloadData1', 'Download'),
                 br(),br()
            )
    ),
    tabItem(tabName = "ui",
            box( width = NULL, status = "primary", solidHeader = TRUE, title="ui.R",
                 downloadButton('downloadData2', 'Download'),
                 br(),br())
    )
  ),
  tabItem(tabName = "about")
)



ui <- dashboardPage(skin="red",
  dashboardHeader(title = "Dashboard IPO"),
  sidebar,
  body
)

server <- function(input, output) {
  
  
}

shinyApp(ui, server)
