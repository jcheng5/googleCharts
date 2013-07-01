library(googleCharts)

shinyUI(basicPage(
  googleChartsInit(),
  googleScatterChart('chart', width='100%', height='400px',
    options = list(
      vAxis = list(
        minValue = 0
      )
    )
  ),
  tableOutput('selected'),
  googleGauge('gauge', width='100%', height='400px',
    list(
      redFrom = 90,
      redTo = 100,
      yellowFrom = 70,
      yellowTo = 90
    )
  )
))