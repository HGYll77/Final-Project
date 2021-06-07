library(shiny)
library(dplyr)
library(ggplot2)
library(rsconnect)

cases_data <- read.csv("Cases.csv")
hosp_data <- read.csv("Hospitalizations.csv")
death_data <- read.csv("Deaths.csv")


ui <- fluidPage(
  # Application title
  titlePanel("Weekly Counts of COVID-19 by counties in WA"),
  
  # Sidebar with a check box that allow user to select states
  sidebarLayout(

      sidebarPanel(
        checkboxGroupInput("County", label = "Select counties", choices = unique(cases_data$County))
      ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("weekPlot"),
      textOutput("Summary")
    )
  ))



server <- function(input, output) {
  sample <- reactive(
    if(is.null(input$County)) {
      cases_data 
    } else {
      cases_data %>%
        filter(County %in% input$County)
    }
  )
  

   output$weekPlot <- renderPlot({
     ggplot(sample()) + 
       geom_line(aes(x = WeekStartDate, y = TotalCases, color= County)) + 
       xlab("date") + ylab("number of cases")+
       theme(plot.title = element_text(size = 20, face = "bold"),
             axis.title.x = element_text(size= 14),
             axis.title.y = element_text(size= 14))
     
   })
   
   output$Summary <- renderText({
     paste0("As we can see in the graph, all counties reach two peaks at ... ....")})
}

shinyApp(ui, server)