library(dplyr)

shinyServer(function(input, output, session) {
  yearData <- reactive({
    # Filter to the desired year, and put the columns
    # in the order that Google's Bubble Chart expects
    # them (name, x, y, color, size). Also sort by region
    # so that Google Charts colors the regions consistently
    # (thanks Prof. Gelman).
    df <- data %.%
      filter(Year == input$year) %.%
      select(Country, Health.Expenditure, Life.Expectancy,
        Region, Population) %.%
      arrange(Region)
  })

  output$chart <- reactive({
    # Return the data and options
    list(
      data = googleDataTable(yearData()),
      options = list(
        title = sprintf(
          "Health expenditure vs. life expectancy, %s",
          input$year)
      )
    )
  })
})
