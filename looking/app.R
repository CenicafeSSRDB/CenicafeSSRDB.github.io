#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(ggplot2)
library(ggedit)
library(dplyr)
library(readxl)
library(DT)

#Database upload
data <- read_excel("DataBase_Markers_CENHV.xlsx")


#Primers DataTables
primer1 <- data.frame(Marker_ID=data$Marker_ID, Forward_Primer=data$FORWARD_PRIMER1, T_For=data$Tm_F1, Size_For=data$size_F1, Reverse_Primer=data$REVERSE_PRIMER1, T_Rev=data$Tm_R1, Size_Rev=data$size_R1)
primer2 <- data.frame(Marker_ID=data$Marker_ID, Forward_Primer=data$FORWARD_PRIMER2, T_For=data$Tm_F2, Size_For=data$size_F2, Reverse_Primer=data$REVERSE_PRIMER2, T_Rev=data$Tm_R2, Size_Rev=data$size_R2)
primer3 <- data.frame(Marker_ID=data$Marker_ID, Forward_Primer=data$FORWARD_PRIMER3, T_For=data$Tm_F3, Size_For=data$size_F3, Reverse_Primer=data$REVERSE_PRIMER3, T_Rev=data$Tm_R3, Size_Rev=data$size_R3)

#DataBase adjustment
datos <- data.frame(Marker_ID=data$Marker_ID, Coordinates=data$Coordinates_Hv33_genome, SSR_Size=data$SSR_size, Sequence=data$SSR_summary_sequence,
                    SSR_Type=data$SSR_type)
#New Databases
p1 <- left_join(datos, primer1, by= "Marker_ID")
p2 <- left_join(datos, primer2, by= "Marker_ID")
p3 <- left_join(datos, primer3, by= "Marker_ID")

# Define UI
ui <- dashboardPage(
        dashboardHeader(disable = TRUE),
      
        dashboardSidebar(
            sidebarMenu(
                menuItem("SSR options", tabName = "SSR_options", icon = icon("dna")),
                selectizeInput('types', 'SSR Type', choices = c(unique(as.character(datos$SSR_Type))),
                               options = list(placeholder = 'Type to choose a SSR Type',
                               onInitialize = I('function() { this.setValue(""); }'))),
                sliderInput("sizes", "SSR Size:", min = 12, max = 191, value = c(12,191)),
                menuItem("Primers options", tabName = "Primer_options", icon = icon("vial")),
                selectizeInput('primers', 'Primers', choices = c("Primer 1", "Primer 2", "Primer 3"),
                               options = list(placeholder = 'Type to choose a primer',
                               onInitialize = I('function() { this.setValue(""); }')))
            )
        ),
        # Body.
        dashboardBody(
            fluidRow(
                box(title = "SSR Hemileia vastatrix",
                    solidHeader = T,
                    width = 12,
                    collapsible = T,
                    div(DT::DTOutput("table"), style = "font-size: 100%;")
                    )
        ))
        )

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    
    
    output$table <-  DT::renderDataTable({
        DT::datatable({d <- datos
                      if (input$primers == "Primer 1" | input$primers == "" ){
                         d <- p1 
                      } else if (input$primers == "Primer 2"){
                         d <- p2
                      } else if (input$primers == "Primer 3"){
                          d <- p3
                      }
                      if (input$types != "") {
                          d  <- d[d$SSR_Type == input$types,]
                      }
                      d <- d[d$SSR_Size >= input$sizes[1] & d$SSR_Size <= input$sizes[2],]
                      d
        })
        })
    
}


# Run the application 
shinyApp(ui = ui, server = server)
