library(shiny)

shinyUI(fluidPage(
  
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
))
