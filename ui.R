library(shiny)
library(ggplot2)
library(datasets)

# load data
ndata <- mtcars

fluidPage(
      
      titlePanel("Relation between vehicle parameters and mileage per gallon (MPG)"),
      
      sidebarPanel(
            
            h6('Note:This app shows you the relation between vehicle MPG and four important vehicle parameters. In section I, you can draw MPG vs. parameter as you choose. In section II, you can predict MPG based on parameters you input. The result is based on statistical data from 32 popular automobile models and optimized linear regression.'),
            h4('I. MPG vs. vehicle parameter as you choose below'),
            
            
            selectInput('para', 'parameter', c('transmission','# of cylinders','horsepower','weight')),
            
            h4('II. Predict MPG value based on paramerters as you input below'),
            
            selectInput('transtype', 'Transmission type', c('auto','manual')),
            selectInput('cyl', '# of cylinders', c('4','6','8')),
            
            sliderInput('hp', 'Horsepower', min=1, max=500,
                        value=mean(ndata$hp), step=1, round=TRUE),
      
            sliderInput('wt', 'Weight (lb/1000)', min=1, max=6,
                  value=mean(ndata$wt), step=0.1, round=TRUE)
      ),
      
      mainPanel(
            h4('I. Figure of MPG vs. parameter chosen in the left'),
            plotOutput('plot'),
            
            h4('II. The predicted MPG value based on your input parameters is'),
            verbatimTextOutput("predmpg")
      )
)