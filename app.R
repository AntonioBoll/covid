library(shiny)
library(shinydashboard)
library(readxl)
library(tidyverse)
library(DT)
library(ggplot2)
library(waffle)
library(kableExtra)
library(dplyr)
library(arrow)
library(plotly)
#Banco de dados

covidusa <- read.csv("national-history.csv")

#ui

ui <- dashboardPage(
  skin = "black",
  header <- dashboardHeader(title= "Covid",
                            dropdownMenu(type = "messages",
                                         messageItem(
                                           from = "GitHub",
                                           message = "Aplicativo criado por Antônio Oss Boll"
                                         )
                            )
  ),
  
  
  sidebar <- dashboardSidebar(
    sidebarMenu(
      menuItem("Covid", tabName = "CovidUSA", icon = icon("virus"))
    )
  ),
  
  body <- dashboardBody(
    tabItems(
      tabItem("CovidUSA",
              fluidPage(
                titlePanel("COVID DATA FROM THE USA"),
                fluidRow(
                  fluidPage(
                    titlePanel("Time series with death by covid."),
                    fluidRow(
                    ),
                    mainPanel(
                      plotlyOutput("graf", height = "600px"),
                      width = 12
                    )
                  )
                )
              )
              
      )
      
    )
    
  )
)


dashboardPage(header, sidebar, body)


# server


server <- function(input, output) {
  
  
  output$graf <- renderPlotly({
    data <- data.frame(
      day = as.Date(covidusa$date),
      value = covidusa$death
    )
    
    p =ggplot(data, aes(x= day, y= value)) +
      geom_line()
    
    p+ scale_x_date(date_labels = "%b")
    p
    
  })
  
}

shinyApp(ui, server)