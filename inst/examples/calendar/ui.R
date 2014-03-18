library(googleCharts)

shinyUI(basicPage(
  googleChartsInit(),
  googleCalendar('calendar', width='100%', height='400px')
))
