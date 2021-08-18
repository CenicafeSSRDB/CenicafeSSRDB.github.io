#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(ggedit)
library(dplyr)
library(readxl)
library(DT)

d <- read_excel("DataBase_Markers_CENHV.xlsx")
datos <- data.frame(Marker_ID=d$Marker_ID, Coordinates=d$Coordinates_Hv33_genome, Size=d$SSR_size,
                    Type=d$SSR_type, Forward_Primer=d$FORWARD_PRIMER1, Reverse_Primer=d$REVERSE_PRIMER1)

# Define UI for application that draws a histogram
ui <- fluidPage(
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

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    mydata <- reactive({
        datos %>%
            req(input$Sizes, input$Types)
        if(input$Sizes == "All"){
            datos
        }
        if (input$Types == "All"){
            datos
        }
    })
    
    
    output$table <- DT::renderDataTable(DT::datatable(mydata()))
}

# Run the application 
shinyApp(ui = ui, server = server)
