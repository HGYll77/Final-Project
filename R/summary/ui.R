library(shiny)

shinyUI(fluidPage(

    titlePanel("Summary Page"),

    sidebarLayout(
        sidebarPanel(
          h3("Analysis, Data Quality, and Future Ideas"),
          selectInput("summaries", label = h4("Select Box"), 
                      c("Analysis" , "Data Quality", "Future Idea"),
                      selected = "Analysis")
          ),

        mainPanel(
            textOutput("summary"),
            br(),
            img(src = "mask.jpg",height = 400, width = 500)
        )
    )
))
