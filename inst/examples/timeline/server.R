library(googleCharts)

shinyServer(function(input, output, session) {
  output$timeline <- reactive({
    list(
      data = googleDataTable(
        data.frame(
          President = c("Washington", "Adams", "Jefferson"),
          Start = as.Date(c("1789-03-29", "1797-02-03", "1801-02-03")),
          End = as.Date(c("1797-02-03", "1801-02-03", "1809-02-03"))
        )
      )
    )
  })
})