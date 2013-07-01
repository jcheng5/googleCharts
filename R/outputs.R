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
googleAreaChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'area', width, height, options, ...)
}

#' @export
googleBarChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'bar', width, height, options, ...)
}

#' @export
googleScatterChart <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'scatter', width, height, options, ...)
}

#' @export
googleGauge <- function(id, width, height, options = list(), ...) {
  googleOutput(id, 'gauge', width, height, options, ...)
}