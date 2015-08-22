library(shiny)

fitGalton <- readRDS("galtonFit.rds")

lowerConf <<- 0
upperConf <<- 0

predictHeight <- function(input) {
  newData = data.frame("mother" = input$mother,
                       "father" = input$father,
                       "gender" = input$gender)
  pred <- predict(fitGalton, newData, interval='confidence')
  lowerConf <<- pred[2]
  upperConf <<- pred[3]
  round(pred[1],1)
}

shinyServer(function(input,output){
    
  output$height <- renderText({
    if(input$goButton > 0) {
      isolate(paste(as.character(predictHeight(input)), " inches"))
    }
  })
  
  output$confidenceLower <- renderText({
    if(input$goButton > 0) {
      isolate(paste(as.character(round(lowerConf, 1)), " inches"))
    }
  })

  output$confidenceUpper <- renderText({
    if(input$goButton > 0) {
      isolate(paste(as.character(round(upperConf, 1)), " inches"))
    }
  })

})

