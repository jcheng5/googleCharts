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
  googleTable('selected', width='200px', height='100px'),
  googleGauge('gauge', width='100%', height='200px',
    list(
      redFrom = 90,
      redTo = 100,
      yellowFrom = 70,
      yellowTo = 90
    )
  ),
  googleSankey('sankey', width='100%', height='200px')
))
