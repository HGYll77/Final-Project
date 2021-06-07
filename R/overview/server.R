library(shiny)

shinyServer(function(input, output) {

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
  
})
