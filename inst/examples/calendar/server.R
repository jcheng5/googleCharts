library(googleCharts)

shinyServer(function(input, output, session) {
  output$calendar <- reactive({
    list(
      data = googleDataTable(
        data.frame(
          Date = seq(as.Date('2013-01-01'), as.Date('2013-12-31'), by=1),
          Value = rnorm(365)
        )
      ),
      options = list(
        title = "Random numbers"
      )
    )
  })
})
