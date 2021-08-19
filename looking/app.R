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

#Database upload
d <- read_excel("DataBase_Markers_CENHV.xlsx")
datos <- data.frame(Marker_ID=d$Marker_ID, Coordinates=d$Coordinates_Hv33_genome, Size=d$SSR_size,
                    Type=d$SSR_type, Forward_Primer=d$FORWARD_PRIMER1, Reverse_Primer=d$REVERSE_PRIMER1)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$table <- DT::renderDataTable(DT::datatable({
        data <-  datos[datos$Size >= input$sizes[1] & datos$Size <= input$sizes[2],]
        if (input$types != "All") {
            data <- data[data$Type == input$types,]
        }
        data 
        }))
}

# Define UI
ui <- fluidPage(
    titlePanel("Basic DataTable"),
    theme = "sandstone",
    
    sidebarLayout(
        sidebarPanel(
            sliderInput("sizes", "Size:",
                        min = 12, max = 191, value = c(12,191)),
            
            selectInput("types",
                        "Type:",
                        c("All", unique(as.character(datos$Type))),
                        selected = "All")
        ),
        # Create a new row for the table.
        mainPanel(
            tabPanel("datos", DT::dataTableOutput("table")),
        )))

# Run the application 
shinyApp(ui = ui, server = server)
