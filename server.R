
## ---------------------------------------------------------------------
## shiny server side code
## ---------------------------------------------------------------------
shinyServer(function(input, output, session) {
  
  fitText <- ''
  ## ---------------------------------------------------------------------
  ## get output based on the selection from the drop down boxes
  ## ---------------------------------------------------------------------
  mtcarsCols <- reactive({
    mtcars[, c(input$x, input$y)]
  })

  ## ---------------------------------------------------------------------
  ## calculate output for cluster plot
  ## ---------------------------------------------------------------------
  kMeansCars <- reactive({
    kmeans(mtcarsCols(), input$number)
  })

  ## ---------------------------------------------------------------------
  ## Plot Clusters
  ## ---------------------------------------------------------------------
  output$kmeansplot <- renderPlot({
    par(mar = c(5, 4, 0, 1))
    plot(mtcarsCols(), col = kMeansCars()$cluster, pch=20, cex=3)
    points(kMeansCars()$centers, pch=4, cex=4)
  })

  ## ---------------------------------------------------------------------
  ## Regression Plot
  ## ---------------------------------------------------------------------
  output$regressionsplot <- renderPlot({
    dfmt <- mtcars[, c(input$x, input$y)]
    names(dfmt)[1] <- paste('x')
    names(dfmt)[2] <- paste('y')
    fit <- lm( dfmt$y ~ dfmt$x, data=dfmt )
    plot( dfmt$y ~dfmt$x, xlab=input$x, ylab=input$y )
    abline(fit)
  })

  ## ---------------------------------------------------------------------
  ## text output of fit
  ## ---------------------------------------------------------------------
  output$fit <- renderPrint({
    dfmt <- mtcars[, c(input$x, input$y)]
    names(dfmt)[1] <- paste('x')
    names(dfmt)[2] <- paste('y')
    fit <- lm( dfmt$y ~ dfmt$x, data=dfmt )
    plot( dfmt$y ~dfmt$x, xlab=input$x, ylab=input$y )
    summary(fit)
  })

}) ## end of shinyServer
