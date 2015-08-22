library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Height Estimator"),
  sidebarPanel(
    selectInput("gender",
                label = h3("Your Gender:"),
                list("Male" = "male",
                     "Female" = "female")),
    
    numericInput("mother",
                 label = h3("Height of Mother:"),
                 value = 65),

    numericInput("father",
               label = h3("Height of Father:"),
               value = 69),
    
    actionButton("goButton", "Estimate Me!")
    
    ),
  
    mainPanel(
      h3('Description'),
      p("This application estimates your height from your parents' height, based on a linear regression 
          fitted on the GaltonFamily data in R's HistData library."),
      h3('Your Height:'),
      textOutput('height'),
      h3('95% Confidence Interval'),
      h4('Lower'),
      textOutput('confidenceLower'),
      h4('Upper'),
      textOutput('confidenceUpper'))
))