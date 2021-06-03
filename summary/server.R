library(shiny)

shinyServer(function(input, output) {

  output$summary <- renderText({ 
    if(input$summaries == "Analysis"){
    
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

})


