library(googleCharts)

shinyUI(basicPage(
  googleChartsInit(),
  googleTimeline('timeline', width='100%', height='400px')
))
