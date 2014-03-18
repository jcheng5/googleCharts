setMethod("toJSON", "Date",
          function(x, container =  isContainer(x, asIs, .level),
                   collapse = "\n", ..., .level = 1L,
                   .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", pretty = FALSE, asIs = NA) {
            toJSON(gsub("-", "/", as.character(x)), container, collapse, ..., .level = .level, .withNames = .withNames, .na = .na, pretty = pretty, asIs = asIs)
          })

chartlibs = list(
  corechart = 'corechart',

  annotatedtimeline = 'annotatedtimeline',
  area = 'corechart',
  bar = 'corechart',
  bubble = 'corechart',
  calendar = 'calendar',
  candlestick = 'corechart',
  column = 'corechart',
  combo = 'corechart',
  gauge = 'gauge',
  geo = 'geochart',
  geomap = 'geomap',
  histogram = 'corechart',
  intensitymap = 'intensitymap',
  line = 'corechart',
  map = 'map',
  motion = 'motionchart',
  org = 'orgchart',
  pie = 'corechart',
  scatter = 'corechart',
  steppedarea = 'corechart',
  table = 'table',
  timeline = 'timeline',
  treemap = 'treemap',
  sankey = 'sankey'
)

#' Initialize Google Charts
#' 
#' This must be called in \code{shinyUI} to load the appropriate Google 
#' Charts JavaScript libraries into the page.
#' 
#' @param chartTypes Character vector that specifies the types of charts
#'   that will be used on this page.
#'
#' @examples
#' TODO
#'   
#' @export
googleChartsInit <- function(chartTypes = c('ALL',
  'annotatedtimeline',
  'area',
  'bar',
  'bubble',
  'calendar',
  'candlestick',
  'column',
  'combo',
  'gauge',
  'geo',
  'geomap',
  'intensitymap',
  'line',
  'map',
  'motion',
  'org',
  'pie',
  'sankey',
  'scatter',
  'steppedarea',
  'table',
  'timeline',
  'treemap')) {

  addResourcePath('googleCharts', system.file('www', package='googleCharts'))

  libs <- character()
  if ('ALL' %in% chartTypes) {
    libs <- as.character(unique(chartlibs))
  } else {
    libs <- sapply(chartTypes, function(type) {
      if (is.null(chartlibs[[type]]))
        stop('Unknown chart type ', type)
      return(chartlibs[[type]])
    })
  }

  tagList(
    tags$script(type='text/javascript', src='https://www.google.com/jsapi'),
    tags$script(HTML(
      sprintf('google.load("visualization", "1.1", {packages: %s});',
              RJSONIO::toJSON(libs))
    )),
    tags$script(src='googleCharts/bindings.js')
  )
}

joinattr <- function(name, value, attrs) {
  if (is.null(attrs[[name]]))
    return(value)
  else
    return(paste(value, attrs[[name]]))
}

#' Set selection on active Google Chart
#' @export
googleSetSelection <- function(session, id, selection) {
  session$sendCustomMessage(
    'googleCharts.setSelection',
    list(id = id, selection = selection)
  )
}

googleOutput <- function(outputId, class, width, height, options, ...) {
  args <- list(...)
  
  className <- paste('shiny', 'google', class, 'output', sep='-')
  args$class <- joinattr('class', className, args)
  style <- sprintf('width:%s;height:%s;',
    validateCssUnit(width), validateCssUnit(height))
  args$style <- joinattr('style', style, args)
  args$id <- outputId
  
  # By default, empty lists are stringified to [], not {}. The client
  # expects the latter.
  if (length(options) == 0)
    options <- RJSONIO::emptyNamedList
  
  div <- do.call(tags$div, args)
  return(tagAppendChild(
    div,
    tags$script(type='application/json', RJSONIO::toJSON(options))
  ))
}

#' Create a Google Chart
#' 
#' These functions are intended to be used in a Shiny application's ui.R
#' file to create a Google chart of the appropriate type. \strong{Don't 
#' forget to call \code{\link{googleChartsInit}} in the ui.R file as
#' well!}
#' 
#' @param id The output variable name for this chart.
#' @param width The width of the chart, in CSS units (e.g. 
#'   \code{"600px"} (for 600 pixels), \code{"75\%"}, or \code{"auto"}) 
#'   or as a number (for pixels).
#' @param height The width of the chart, in CSS units or as a number.
#' @param options A list containing named chart options, to be used when
#'   creating the chart. Nested lists should be used for nested options,
#'   e.g. \code{list(hAxis = list(maxValue = 100))}.
#' @param ... Additional tag attributes or child elements to include in 
#'   the chart's \code{<div>}.
#'
#' @examples TODO
#'   
#' @rdname googleChart
#' @export
googleAnnotatedTimeLine <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'annotatedtimeline', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleAreaChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'area', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleBarChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'bar', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleBubbleChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'bubble', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleCandlestickChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'candlestick', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleColumnChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'column', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleComboChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'combo', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleGauge <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'gauge', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleGeoChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'geo', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleGeoMap <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'geomap', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleIntensityMap <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'intensitymap', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleLineChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'line', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleMap <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'map', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleMotionChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'motion', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleOrgChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'org', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googlePieChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'pie', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleScatterChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'scatter', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleSteppedAreaChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'steppedarea', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleTable <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'table', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleTreeMap <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'treemap', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleSankey <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'sankey', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleCalendar <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'calendar', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleHistogram <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'histogram', width, height, options, ...)
}

#' @rdname googleChart
#' @export
googleTimeline <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'timeline', width, height, options, ...)
}
