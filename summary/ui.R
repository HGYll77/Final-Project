library(shiny)

shinyUI(fluidPage(

    titlePanel("Summary Page"),

    sidebarLayout(
        sidebarPanel(
          h3("Data Analysis, Data Quality, and Future Ideas"),
          selectInput("summaries", label = h4("Select Box"), 
                      c("Data Analysis 1" , "Data Analysis 2",
                        "Data Quality", "Future Idea"),
                      selected = "Data Analysis 1")
          ),

        mainPanel(
            textOutput("summary"),
            br(),
            img(src = "mask.jpg",height = 400, width = 500)
        )
    )
))
