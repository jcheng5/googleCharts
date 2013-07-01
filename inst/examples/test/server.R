library(googleCharts)

maxValue <- 4

shinyServer(function(input, output, session) {

  rnd <- reactive({
    invalidateLater(6000, session)

    len <- 10
    data.frame(
      x = 1:len,
      y = runif(len, min = 0, max = maxValue),
      z = runif(len, min = 0, max = maxValue)
    )
  })
  
  output$chart <- reactive({
    list(
      data = googleDataTable(
        rnd()
      ),
      options = list(
        animation = list(
          duration=400,
          easing='inAndOut'
        ),
        vAxis = list(
          maxValue = maxValue
        )
      )
    )
  })
  
  output$gauge <- reactive({
    invalidateLater(1000, session)
    list(
      data = googleDataTable(
        data.frame(Value = I(runif(1, min=0, max=100)))
      )
    )
  })

  output$selected <- renderTable({
    if (is.null(input$chart_selection))
      return(NULL)
    
    print(input$chart_selection)
    
    isolate({
      # Indices are 0-based in Google parlance, but 1-based in R
      rownum <- input$chart_selection[['row']] + 1
      colnum <- input$chart_selection[['column']] + 1
      
      data <- rnd()
      row <- data[rownum,]
      colname <- names(data)[[colnum]]
      df <- data.frame(x = row$x)
      df[[colname]] <- row[1,colname]
      df
    })
  })

})