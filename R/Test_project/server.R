library(shiny)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(maps)
library(stringr)
library(lubridate)

# Read data
case_data <- read.csv("Data/Cases.csv")
case_data$WeekStartDate <- ymd(case_data$WeekStartDate)
hosp_data <- read.csv("Data/Hospitalizations.csv")
death_data <- read.csv("Data/Deaths.csv")


# Define server logic required to draw a histogram
function(input, output) {
    histog_data <- reactive({
        case_data %>%
            group_by(County)%>%
            summarise(age019 = sum(Age.0.19), age2034 = sum(Age.20.34),
                      age3549 = sum(Age.35.49), age5064 = sum(Age.50.64),
                      age6579 = sum(Age.65.79), age80 = sum(Age.80.), total = sum(TotalCases))%>%
            mutate(Cases = age6579+age80) %>% 
            arrange(-Cases)%>%
            head(input$num) %>% 
            select(County, matches(input$age)) 
        
    })
    
    output$distPlot <- renderPlot({
        ggplot(histog_data()) +
            geom_bar(mapping = aes(x = County, y = Cases), fill = "skyblue", stat = "identity") + coord_flip()
    })
    
    output$distPlot_cat <- renderText({
        paste("The histogram shows the top", input$num, "counties with highest cases of COVID-19 among elders
               in Washington State. Elders are more susceptible to COVID-19 and it is really danger especially
               to people over 65. Normally if an elder people gets COVID, he or she is more likely to need proper
               treatment in the hospital, which means WA should allocate more health resources to counties with high
               number of cases for elder people such as King County. So this histogram could help the government prepare
               for the next similar outbreak and reduce the number of people dying through the proper distribution 
               of medical supplies.")
               
    })
    
    output$picDesc <- renderText({
        paste0("The picture below shows the SARS-CoV-2, which causes COVID-19.",
               "Researching about the virus reveals that COVID-19 is much deadlier ",
               "and causes more health problem than normal flus.")
    })
    
    output$intro <- renderText({
        paste0("Since the beginning of 2020, COVID-19 has continued to spread in the United States.",
               "The first reported case occurred in Seattle, Washington.",
               "Although people did not take it seriously at the time,",
               "as the number of reported cases increased sharply and the situation became more severe,",
               "everyone was paying attention to the development of the epidemic.",
               " Our research and analysis would mainly focus on the situation in Washington State. ")
    })
    
    output$overview <- renderText({
        paste0("Our target audience is WA residents. For people living",
               "in Washington State, they would like to know how the situation is.",
               "For example, how many cases are there recently? ",
               "Is it dangerous for me to go to another county now?")
    })
    
    choose_data <- reactive({
        if (input$cases_deaths == "deaths") {
            cases_data <- death_data %>%
                group_by(County) %>%
                summarize(sum_cases = sum(Deaths)) %>%
                mutate(subregion = tolower(County)) %>%
                filter(subregion != "unassigned") %>%
                select(sum_cases, subregion)
            cases_data$subregion <- substr(cases_data$subregion,1,nchar(cases_data$subregion)-7)
            mid <- mean(cases_data$sum_cases)
        } else {
            cases_data <- case_data %>%
                group_by(County) %>%
                summarize(sum_cases = sum(TotalCases)) %>%
                mutate(subregion = tolower(County)) %>%
                filter(subregion != "unassigned") %>%
                select(sum_cases, subregion)
            cases_data$subregion <- substr(cases_data$subregion,1,nchar(cases_data$subregion)-7)
            mid <- mean(cases_data$sum_cases)
        }
        county_data <- map_data("county") %>%
            filter(region == "washington") %>%
            left_join(cases_data)
        
    })
    
    output$map <- renderPlot({
        ggplot(choose_data(), aes(long, lat, group = group, fill = sum_cases)) + 
            geom_polygon(col = 'black')  + 
            if (input$cases_deaths == "deaths") {
                labs(title = 'WA state counties map', fill = "County Sum Deaths") 
            } else {
                labs(title = 'WA state counties map', fill = "County Sum Cases") 
            } +
            scale_fill_gradient2(midpoint = mid, low = 'green', mid = 'lightblue', high = 'deepskyblue') +
            coord_quickmap()
    })
    
    output$summary_map <- renderText({
        max_county <- choose_data() %>%
            arrange(desc(sum_cases))
        if (input$cases_deaths == "deaths") {
            paste("The", max_county$subregion[1], "county has the largest number of deaths which is",
                  max_county$sum_cases[1], ".")
        } else {
            paste("The", max_county$subregion[1], "county has the largest number of cases which is",
                  max_county$sum_cases[1], ".")
        }
    })
    
    sample <- reactive({
        if(is.null(input$County)) {
            case_data 
                
        } else {
            case_data %>%
                filter(County %in% input$County)
            
        }
    })
    
    
    output$weekPlot <- renderPlot({
        #sample$WeekStartDate <- ymd(sample$WeekStartData)
        ggplot(sample()) + 
            geom_line(aes(x = WeekStartDate, y = TotalCases, color= County)) + 
            xlab("date") + ylab("number of cases")+
            theme(plot.title = element_text(size = 20, face = "bold"),
                  axis.title.x = element_text(size= 14),
                  axis.title.y = element_text(size= 14))
        
    })
    
    output$Summary <- renderText({
        paste0("As we can see in the graph, all counties reach two peaks at ... ....")})
    
    output$summary <- renderText({ 
        if(input$summaries == "Data Analysis 1"){
            paste0("From the map, we could see that King County has the highest number of cases in total, ",
                   "followed by Pierce County and Spokane County.",
                   " After drawing out the cases by age, we  find a similar pattern.",
                   "From the histogram about cases of COVID-19 by age, the first ",
                   "one is also King County, Pierce County is the second, and Spokane ",
                   "County is the third.Among the people aged 50+, King county has the  ",
                   "highest number of confirmed cases. The elderly may have more health problems, and ",
                   "COVID-19 may bring even more health problems to them. Therefore, Washington State ",
                   "can consider placing relatively more medical resources in these states, like King County ",
                   "and Spokane County. Nevertheless, we cannot conclude that the rate of COVID-19 in ",
                   "King County is higher than in other counties. The case rate equals \"Number of cases ",
                   "with a specimen collection date in the 14-day period\" divided by Population. So, ",
                   "population is also a factor that impacts the rate. ")
        }else if (input$summaries == "Data Analysis 2"){
            paste0("We believe that vaccination has an impact on limiting the spread of the coronavirus. ",
                   "According to the news, starting from about January 2021,large numbers of residents in ",
                   "Washington State began to get a vaccine. At that time, the total number of existing cases and ",
                   "the number of new cases began to decline significantly. Therefore, we believe that ",
                   "vaccination can suppress the spread of the virus. Of course, there are also other factors ",
                   "that affect the spread of the virus. For instance, masks can also reduce the probability ",
                   "of being infected. Since Nov.2020, there have been many occasions where people were ",
                   "required to wear masks or facial coverings. In the following period of time, the number ",
                   "of new cases also dropped obviously. According to our analysis and information ",
                   "accessed from government agencies, masks and vaccines can effectively reduce the ",
                   "risk of infection. For those who are fully vaccinated, they can choose to wear a mask ",
                   "only when necessary. For those who are not fully vaccinated, wearing a mask and ",
                   "keeping a safe distance is the best choice.")
        }else if(input$summaries == "Data Quality"){
            paste0("First of all, this dataset is collected and downloaded from an official agency,",
                   "the Washington State Department of Health. ",
                   " Therefore, we would say that the credibility is fairly high,",
                   "or it is almost impossible for us to find more reliable data than this.",
                   "We think our dataset is relatively high-quality ",
                   "because it has very clear data and is very detailed. ",
                   "We can track new cases every week, and we can know",
                   "how many new cases are in each age group among these new cases. ",
                   "Second, we would say that our dataset gives unbiased results.",
                   "This dataset is a collection of weekly new cases",
                   " for each county in Washington State. It did not perform any sampling techniques.",
                   " In addition, collection of data does not come from surveys ",
                   "or ask people questions that can cause bias. The data is directly derived from the test,",
                   "and there would be errors unless there is a problem with the test.",
                   "It’s not obvious that certain population groups are harmed.")
        }else{
            paste0("In the future, if we can merge the data of total population of Washington State, ",
                   "the total population of each county, and the gender of new cases into our original table,",
                   "we can analyze more content. For example, does gender affect the infection rate of the COVID-19? ",
                   "Are older people more likely to be infected with the COVID-19? ",
                   "With a more detailed dataset, we can get the infection rate of each group, ",
                   "and then find the answer by comparing the rate.")
        }
        
    })
    
}
