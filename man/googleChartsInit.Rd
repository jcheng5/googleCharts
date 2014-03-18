\name{googleChartsInit}
\alias{googleChartsInit}
\title{Initialize Google Charts}
\usage{
  googleChartsInit(chartTypes = c("ALL", "annotatedtimeline", "area", "bar", "bubble", "calendar", "candlestick", "column", "combo", "gauge", "geo", "geomap", "intensitymap", "line", "map", "motion", "org", "pie", "sankey", "scatter", "steppedarea", "table", "timeline", "treemap"))
}
\arguments{
  \item{chartTypes}{Character vector that specifies the
  types of charts that will be used on this page.}
}
\description{
  This must be called in \code{shinyUI} to load the
  appropriate Google Charts JavaScript libraries into the
  page.
}
\examples{
TODO
}

