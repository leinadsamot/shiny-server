library(shiny)
library(shinydashboard)
library(highcharter)
library(dplyr)

ui <- dashboardPage(
  dashboardHeader(title = "Euro tostões"),
  dashboardSidebar(
    sidebarMenu(
                 menuItem(tabName = "menu","Menu", icon = icon("euro")),
                 menuItem(tabName = "dados","Dados", icon = icon("table")),
                 br(),
                 fileInput("file1", "Insere o ficheiro",
                           accept = c(
                             "text/csv",
                             "text/comma-separated-values,text/plain",
                             ".csv"))
                )
              ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "menu",
        fluidRow(
          h1("Menu",style="text-align: left; padding:10px;"),
          infoBoxOutput(outputId = "a4",width = 3),
          infoBoxOutput(outputId = "a5",width = 3),
          infoBoxOutput(outputId = "a6",width = 3),
          infoBoxOutput(outputId = "a3",width = 3),
          box(title = "Gráfico dos prémios",collapsible = T, width = 12,
              highchartOutput("plot")
              )
          
        )
      ),
      tabItem(
        tabName = "dados",
        fluidRow(
          h1("Dados",style="text-align: left; padding:10px;"),
          box(title = "Tabela",collapsible = T, width = 12,tableOutput(outputId = "a2"))
        )
      )
    )
  )
)

server <- function(input, output) { 
  output$plot <- renderHighchart({
    
  tostoes = input$file1
  if (is.null(tostoes)){
    NULL
  }else{
    euro = read.csv2(tostoes$datapath, header = T)
    
    hchart(euro,"column",hcaes(x=Data,y=as.numeric(Premio)))%>% hc_add_theme(hc_theme_google())
  }
  
  })
  
  output$a4 = renderInfoBox({
    tostoes = input$file1
    if (is.null(tostoes)){
      infoBox(title = "Nº de semanas",value = NA,color = "blue")
    }else{
      euro = read.csv2(tostoes$datapath, header = T)
      Total = as.numeric(max(euro$Semana))
      Total
      
      infoBox(title = "Nº de semanas",value = Total,color = "blue")
    }
  })
  
  output$a5 = renderInfoBox({
    tostoes = input$file1
    if (is.null(tostoes)){
      infoBox(title = "Investido no /M",value = NA,color = "blue")
    }else{
      euro = read.csv2(tostoes$datapath, header = T)
      Total = sum(as.numeric(euro$Investido))
      Total
      
      infoBox(title = "Investido no /M",value = Total,color = "blue")
    }
  })
  
  output$a6 = renderInfoBox({
    tostoes = input$file1
    if (is.null(tostoes)){
      infoBox(title = "Prémios",value = NA,color = "blue")
    }else{
      euro = read.csv2(tostoes$datapath, header = T)
      Total = sum(as.numeric(euro$Premio))
      Total
      
      infoBox(title = "Prémios",value = Total,color = "blue")
    }
  })
  
  output$a3 = renderInfoBox({
    tostoes = input$file1
    if (is.null(tostoes)){
      infoBox(title = "Rácio Prémios/Investido",value = NA,color = "blue")
    }else{
      euro = read.csv2(tostoes$datapath, header = T)
      Total = round(sum(as.numeric(euro$Premio))/sum(as.numeric(euro$Investido)),2)
      Total
      
      infoBox(title = "Rácio Prémios/Investido",value = Total,color = "blue")
    }
  })
  
  output$a2 = renderTable({
    tostoes = input$file1
    if (is.null(tostoes)){
      NULL
    }else{
      euro = read.csv2(tostoes$datapath, header = T)
    }
    
  })
  
  }

shinyApp(ui, server)
