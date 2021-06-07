#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(markdown)
library(shiny)

navbarPage("Final Project",
    tabPanel("Overview",
        titlePanel("Final Group Project"),
             
        sidebarLayout(
            sidebarPanel(
                h3("SARS-CoV-2"),
                textOutput("picDesc"),
                br(),
                br(),
                img(src = "covid19.jpg",height = 130, width = 200)
                ),
                 
            mainPanel(
                h2("Introduction"),
                br(),
                textOutput("intro"),
                br(),
                br(),
                h2("Overview"),
                br(),
                textOutput("overview"),
                br(),
                br(),
                h2("Data"),
                p("For this assignment, We'll use the dataset about \"Cases, ",
                  "Hospitalization and Deaths of COVID-19 in WA\". ",
                  "The data originates from Washington State Department of Health and we accessed the data from",
                       a("Washington State Department of Health.", 
                         href = "https://www.doh.wa.gov/Emergencies/COVID19/DataDashboard#tables"),
                       "This data record the number of cases, hospitalizations ",
                       "and death of Covid-19 for different aged groups in each  county weekly. ",
                       "It contains the following variables:"),
                     br(),
                     p(strong(em("County:")),"County names"),
                     p(strong(em("WeekStartDate:")),"date of the first day of that week, as yyyy/mm/dd/"),
                     p(strong(em("ProbableCases:")),"# cases that have symptoms, but no positive molecular test during that week"),
                     p(strong(em("ConfirmedCases:")),"# confirmed cases during that week"),
                     p(strong(em("TotalCases:")),"# ProbableCases + ConfirmedCases"),
                     p(strong(em("Hospitalizations:")),"# hospitalization among confirmed and probable cases during that week"),
                     p(strong(em("Deaths:")),"# deaths among confirmed and probable cases during that week"),
                     p(strong(em("Age 0-19:")),"# cases/hospitalizations/deaths who are from age 0-19"),
                     p(strong(em("Age 20-34:")),"# cases/hospitalizations/deaths who are from age 20-34"),
                     p(strong(em("Age 35-49:")),"# cases/hospitalizations/deaths who are from age 35-49"),
                     p(strong(em("Age 50-64:")),"# cases/hospitalizations/deaths who are from age 50-64"),
                     p(strong(em("Age 65-79:")),"# cases/hospitalizations/deaths who are from age 65-79"),
                     p(strong(em("Age 80+:")),"# cases/hospitalizations/deaths who are aged 80 years or older"),
                     p(strong(em("UnknownAge:")),"# cases/hospitalizations/deaths with unknown age")
                 )
             )
        
    ),
    
    tabPanel("Histogram",
        titlePanel("Cases of COVID-19 for elder people in WA"),
        sidebarLayout(
            sidebarPanel(
                selectInput("age", "Age", choices = list("65+" = "Cases"),
                            selected = "Cases"),
                sliderInput("num", "Number of counties to show",
                            min = 3, max = 18, value = 10)
                ),
            mainPanel(
                plotOutput("distPlot"),
                textOutput("distPlot_cat")
                     )
        )
    ),
    
    tabPanel("Map",
             titlePanel("WA state county total cases and deaths situation"),
             
             # Sidebar with a slider input for number of bins
             sidebarLayout(
                 sidebarPanel(
                     radioButtons("cases_deaths", label = "Which data you want to explore:",
                                  choices = list("cases", "deaths"), selected = "cases"),
                 ),
                 
                 # Show a plot of the generated distribution
                 mainPanel(
                     plotOutput("map"),
                     textOutput("summary_map")
                 )
             )
        
    ),
    
    tabPanel("Plot",
             # Application title
             titlePanel("Weekly Counts of COVID-19 by counties in WA"),
             
             # Sidebar with a check box that allow user to select states
             sidebarLayout(
                 sidebarPanel(
                     checkboxGroupInput("County", label = "Select counties", choices = unique(case_data$County))
                 ),
                 
                 # Show a plot of the generated distribution
                 mainPanel(
                     plotOutput("weekPlot"),
                     textOutput("Summary")
                 )
             )
        
    ),
    
    tabPanel("Summary",
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
        
    ),
    
    navbarMenu("Group member",
        tabPanel("Guanyu Huo"),
        tabPanel("Yihui Chen"),
        tabPanel("Tong Chen"),
        tabPanel("Zhuyi Gu")
        
             
        
    )
)
