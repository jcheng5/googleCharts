#' @export
googleDataTable <- function(data, columns = NULL) {
  cols <- NULL
  if (is.null(columns)) {
    cols <- inferColumns(data)
  } else {
    cols <- columns
  }
  
  if (!is.null(names(cols))) {
    if (any(names(cols) == '')) {
      stop('Some but not all column definitions were named. Please ',
           'pass either all named, or all unnamed definitions.')
    }
    
    if (!isTRUE(all.equal(sort(names(cols)), sort(names(data))))) {
      stop('Column definition names did not match data variables')
    }
    
    # Order the cols according to the data
    cols <- cols[match(names(cols), names(data))]
  } else {
    if (length(cols) != length(data)) {
      stop('Incorrect number of columns were passed to googleDataTable',
           '; the number of columns must match the number of variables',
           ' in the data')
    }
    names(cols) <- names(data)
  }
  
  # TODO: Validate no duplicate variable names
  # TODO: Validate no JS-illegal column names
  
  colDefs <- lapply(names(cols), function(colName) {
    def <- cols[[colName]]
    if (is.null(def$id))
      def$id <- colName
    if (is.null(def$label))
      def$label <- def$id
    return(def)
  })
  
  return(list(
    cols = colDefs,
    data = lapply(as.list(data), function(x) {
      I(x)
    })
  ))
}

#' @export
column <- function(
  type = c('boolean', 'number', 'string', 'date', 'datetime', 'timeofday'),
  label = NULL,
  p = NULL) {
  
  col <- list(type = type)
  if (!is.null(label))
    col$label <- label
  if (!is.null(p))
    col$p <- p
  
  return(col)
}

inferColumns <- function(df) {
  lapply(df, function(x) {
    column(type = googleDataType(x))
  })
}

googleDataType <- function(x) {
  UseMethod("googleDataType")
}

googleDataType.numeric <- function(x) {
  'number'
}

googleDataType.integer <- function(x) {
  'number'
}

googleDataType.character <- function(x) {
  'string'
}

googleDataType.logical <- function(x) {
  'boolean'
}

googleDataType.factor <- function(x) {
  'string'
}

googleDataType.Date <- function(x) {
  'date'
}

googleDataType.POSIXct <- function(x) {
  'datetime'
}

googleDataType.AsIs <- function(x) {
  googleDataType(as.vector(x))
}

googleDataType.default <- function(x) {
  stop("Don't know how to infer Google DataTable type for vector of ",
       "class '", paste(class(x), collapse='/'), "'; please provide an explicit column ",
       "definition")
}
