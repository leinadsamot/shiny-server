library(shiny)
library(shinydashboard)
load('Liga NOS v2Final.RData')

ui <- dashboardPage(
  dashboardHeader(title = "Euro tostÃµes"),
  dashboardSidebar(
    sidebarMenu(
                 menuItem(tabName = "menu","Menu", icon = icon("euro")),
                 menuItem(tabName = "dados","Dados", icon = icon("table"))
                )
              ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "menu",
        fluidRow(
              box(plotOutput(outputId = "a"),width = 12,title = "Liga NOS")
              )
          
        ),
      tabItem(
        tabName = "dados",
        fluidRow(
          h1("Dados",style="text-align: left; padding:10px;")

        )
      )
    )
  )
)


server <- function(input, output) { 
output$a=renderPlot(plot(Liga$Totaldechutes,Liga$Possedebola))
  }

shinyApp(ui, server)
