library(ggplot2)
library(ggedit)
library(dplyr)
library(readxl)
library(DT)

d <- read.csv("~/Base_de_datos/DataBase_Markers_CENHV.csv", header=TRUE)
datos <- data.frame(Marker_ID=d$Marker_ID, Coordinates=d$Coordinates_Hv33_genome, Size=d$SSR_size,
                  Type=d$SSR_type, Forward_Primer=d$FORWARD_PRIMER1, Reverse_Primer=d$REVERSE_PRIMER1)

function(input, output) {
  
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
  
  

