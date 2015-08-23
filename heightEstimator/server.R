library(shiny)
library(HistData)
data(GaltonFamilies)

fitGalton <- readRDS("galtonFit.rds")

lowerConf <<- 0
upperConf <<- 0
fit <<- 0

predictHeight <- function(input) {
  newData = data.frame("mother" = input$mother,
                       "father" = input$father,
                       "gender" = input$gender,
                       "childNum" = input$childNum)
  pred <- predict(fitGalton, newData, interval='confidence')
  lowerConf <<- pred[2]
  upperConf <<- pred[3]
  fit <<- pred[1]
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
  
  output$histogram <- renderPlot({
    if(input$goButton > 0) {
      hist(GaltonFamilies$childHeight, xlab="Children's Height", ylab="Frequency",
           main="Histogram of Children's Height from GaltonFamilies")
      abline(v = round(fit,2), col="red")
    } 
  })
  
})

