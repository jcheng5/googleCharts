chartlibs = list(
  corechart = 'corechart',

  annotatedtimeline = 'annotatedtimeline',
  area = 'corechart',
  bar = 'corechart',
  bubble = 'corechart',
  candlestick = 'corechart',
  column = 'corechart',
  combo = 'corechart',
  gauge = 'gauge',
  geo = 'geochart',
  geomap = 'geomap',
  intensitymap = 'intensitymap',
  line = 'corechart',
  map = 'map',
  motion = 'motionchart',
  org = 'orgchart',
  pie = 'corechart',
  scatter = 'corechart',
  steppedarea = 'corechart',
  table = 'table',
  # timeline = 'timeline', # requires version 1.1...?
  treemap = 'treemap'
)

#' @export
googleChartsInit <- function(chartTypes = c('ALL',
  'annotatedtimeline',
  'area',
  'bar',
  'bubble',
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
  'scatter',
  'steppedarea',
  'table',
  # 'timeline',
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
      sprintf('google.load("visualization", "1", {packages: %s});',
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

googleOutput <- function(outputId, class, width, height, options, ...) {
  args <- list(...)
  
  className <- paste('shiny', 'google', class, 'output', sep='-')
  args$class <- joinattr('class', className, args)
  style <- sprintf('width:%s;height:%s;',
    validateCssUnit(width), validateCssUnit(height))
  args$style <- joinattr('style', style, args)
  print(args$style)
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

#' @export
googleAnnotatedTimeLine <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'annotatedtimeline', width, height, options, ...)
}

#' @export
googleAreaChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'area', width, height, options, ...)
}

#' @export
googleBarChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'bar', width, height, options, ...)
}

#' @export
googleBubbleChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'bubble', width, height, options, ...)
}

#' @export
googleCandlestickChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'candlestick', width, height, options, ...)
}

#' @export
googleColumnChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'column', width, height, options, ...)
}

#' @export
googleComboChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'combo', width, height, options, ...)
}

#' @export
googleGauge <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'gauge', width, height, options, ...)
}

#' @export
googleGeoChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'geo', width, height, options, ...)
}

#' @export
googleGeoMap <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'geomap', width, height, options, ...)
}

#' @export
googleIntensityMap <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'intensitymap', width, height, options, ...)
}

#' @export
googleLineChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'line', width, height, options, ...)
}

#' @export
googleMap <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'map', width, height, options, ...)
}

#' @export
googleMotionChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'motion', width, height, options, ...)
}

#' @export
googleOrgChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'org', width, height, options, ...)
}

#' @export
googlePieChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'pie', width, height, options, ...)
}

#' @export
googleScatterChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'scatter', width, height, options, ...)
}

#' @export
googleSteppedAreaChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'steppedarea', width, height, options, ...)
}

#' @export
googleTableChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'table', width, height, options, ...)
}

# #' @export
# googleTimeline <- function(id, width, height, options = list(), ...) {
#   googleOutput(id, 'timeline', width, height, options, ...)
# }

#' @export
googleTreeMap <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'treemap', width, height, options, ...)
}
