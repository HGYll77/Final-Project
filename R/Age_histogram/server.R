
library(shiny)
library(dplyr)
library(ggplot2)

# Read data
cases_data <- read.delim("../../Data/Cases.csv", sep = ",")
hosp_data <- read.delim("../../Data/Hospitalizations.csv", sep = ",")
death_data <- read.delim("../../Data/Deaths.csv", sep = ",")
    

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    histog_data <- reactive({
        cases_data %>%
            group_by(County)%>%
            summarise(Cases = sum(Age.0.19), age2034 = sum(Age.20.34),
                      age3549 = sum(Age.35.49), age5064 = sum(Age.50.64),
                      age6579 = sum(Age.65.79), age80 = sum(Age.80.), total = sum(TotalCases))%>%
            #filter(County == input$County) 
            arrange(Cases)%>%
            head(input$num) %>% 
            
            #filte( = input$age)
            select(County, matches(input$age)) 
            #rename_with.(~ sub("County", "total", .x))
            #colnames[2]<- total
            #rename_if(contains(age), total)
            #colnames(histog_data)[2] <- "total"
            
    })

    output$distPlot <- renderPlot({
        
        
        ggplot(histog_data()) +
            geom_bar(mapping = aes(x = County, y = Cases), fill = "skyblue", stat = "identity") + coord_flip()
            
            
    })
})
