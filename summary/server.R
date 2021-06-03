library(shiny)

shinyServer(function(input, output) {

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

})


