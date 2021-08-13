library(ggplot2)

d <- read_excel("Base_de_datos/DataBase_Markers_CENHV.xlsx")
datos <- data.frame(Marker_ID=d$Marker_ID, Coordinates=d$Coordinates_Hv33_genome, Type=d$SSR_type, Size=d$SSR_size, Forward_Primer=d$FORWARD_PRIMER1, Reverse_Primer=d$REVERSE_PRIMER1)

ui <- fluidPage(
  titlePanel("SRR H.vastatrix"),
  
  # Create a new Row in the UI for selectInputs
  fluidRow(
    column(4,
           selectInput("Size",
                       "Size:",
                       c("All",
                         unique(as.character(datos$Size))))
    ),
    column(4,
           selectInput("Type",
                       "Type:",
                       c("All",
                         unique(as.character(datos$Type))))
    ),
  ),
  # Create a new row for the table.
  DT::dataTableOutput("table")
)


# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  
  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    data <- datos
    if (input$Size != "All") {
      data <- data[data$Size == input$Size,]
    }
    if (input$Type != "All") {
      data <- data[data$Type == input$Size,]
    }
    data
  }))
  
}

# Create Shiny app ----
shinyApp(ui, server)