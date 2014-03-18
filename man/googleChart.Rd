\name{googleAnnotatedTimeLine}
\alias{googleAnnotatedTimeLine}
\alias{googleAreaChart}
\alias{googleBarChart}
\alias{googleBubbleChart}
\alias{googleCalendar}
\alias{googleCandlestickChart}
\alias{googleColumnChart}
\alias{googleComboChart}
\alias{googleGauge}
\alias{googleGeoChart}
\alias{googleGeoMap}
\alias{googleHistogram}
\alias{googleIntensityMap}
\alias{googleLineChart}
\alias{googleMap}
\alias{googleMotionChart}
\alias{googleOrgChart}
\alias{googlePieChart}
\alias{googleSankey}
\alias{googleScatterChart}
\alias{googleSteppedAreaChart}
\alias{googleTable}
\alias{googleTimeline}
\alias{googleTreeMap}
\title{Create a Google Chart}
\usage{
  googleAnnotatedTimeLine(id, width, height,
    options = list(), ...)

  googleAreaChart(id, width, height, options = list(), ...)

  googleBarChart(id, width, height, options = list(), ...)

  googleBubbleChart(id, width, height, options = list(),
    ...)

  googleCandlestickChart(id, width, height,
    options = list(), ...)

  googleColumnChart(id, width, height, options = list(),
    ...)

  googleComboChart(id, width, height, options = list(),
    ...)

  googleGauge(id, width, height, options = list(), ...)

  googleGeoChart(id, width, height, options = list(), ...)

  googleGeoMap(id, width, height, options = list(), ...)

  googleIntensityMap(id, width, height, options = list(),
    ...)

  googleLineChart(id, width, height, options = list(), ...)

  googleMap(id, width, height, options = list(), ...)

  googleMotionChart(id, width, height, options = list(),
    ...)

  googleOrgChart(id, width, height, options = list(), ...)

  googlePieChart(id, width, height, options = list(), ...)

  googleScatterChart(id, width, height, options = list(),
    ...)

  googleSteppedAreaChart(id, width, height,
    options = list(), ...)

  googleTable(id, width, height, options = list(), ...)

  googleTreeMap(id, width, height, options = list(), ...)

  googleSankey(id, width, height, options = list(), ...)

  googleCalendar(id, width, height, options = list(), ...)

  googleHistogram(id, width, height, options = list(), ...)

  googleTimeline(id, width, height, options = list(), ...)
}
\arguments{
  \item{id}{The output variable name for this chart.}

  \item{width}{The width of the chart, in CSS units (e.g.
  \code{"600px"} (for 600 pixels), \code{"75\%"}, or
  \code{"auto"}) or as a number (for pixels).}

  \item{height}{The width of the chart, in CSS units or as
  a number.}

  \item{options}{A list containing named chart options, to
  be used when creating the chart. Nested lists should be
  used for nested options, e.g. \code{list(hAxis =
  list(maxValue = 100))}.}

  \item{...}{Additional tag attributes or child elements to
  include in the chart's \code{<div>}.}
}
\description{
  These functions are intended to be used in a Shiny
  application's ui.R file to create a Google chart of the
  appropriate type. \strong{Don't forget to call
  \code{\link{googleChartsInit}} in the ui.R file as well!}
}
\examples{
TODO
}

