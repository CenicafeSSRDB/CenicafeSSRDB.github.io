library(ggplot2)
library(ggedit)
library(dplyr)
library(readxl)
library(DT)

fluidPage(
  titlePanel("Basic DataTable"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("Sizes",
                       label = "Size:", 
                       choices = c("All", unique(as.character(datos$Size))), 
                       selected = "All", multiple = TRUE),
      selectInput("Types", 
                         label = "Type:", 
                         choices = c("All", unique(as.character(datos$Type))), 
                         selected = "All", multiple = TRUE)
    ),
    # Create a new row for the table.
    mainPanel(
        tabPanel("datos", DT::dataTableOutput("table")),
  )))