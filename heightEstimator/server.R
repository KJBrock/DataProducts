library(shiny)

fitGalton <- readRDS("galtonFit.rds")

lowerConf <<- 0
upperConf <<- 0

predictHeight <- function(input) {
  newData = data.frame("mother" = input$mother,
                       "father" = input$father,
                       "gender" = input$gender,
                       "childNum" = input$childNum)
  pred <- predict(fitGalton, newData, interval='confidence')
  lowerConf <<- pred[2]
  upperConf <<- pred[3]
  round(pred[1],1)
}

shinyServer(function(input,output){
    
  output$height <- renderText({
    if(input$goButton > 0) {
      isolate(paste(as.character(predictHeight(input)), " inches"))
    } else {
      "Please enter your data and click 'Estimate Me!'"
    }
    
  })
  
  output$confidenceLower <- renderText({
    if(input$goButton > 0) {
      isolate(paste(as.character(round(lowerConf, 1)), " inches"))
    } else {
      ""
    }
  })

  output$confidenceUpper <- renderText({
    if(input$goButton > 0) {
      isolate(paste(as.character(round(upperConf, 1)), " inches"))
    } else {
      ""
    }
  })

})

