# project
library(shiny)
library(ggplot2)
library(datasets)

ndata <- mtcars
ndata$am <- as.factor(ndata$am)
ndata$cyl <- as.factor(ndata$cyl)

fit4<-lm(mpg~am+cyl+hp+wt,data=ndata)

function(input, output) {
      
      
      # Drwa the MPG ~ parameter plot
      output$plot <- renderPlot({
            if (input$para=='transmission') {
            boxplot(mpg~am,data=ndata, col=c("red3","blue3"), xlab="transmission type",ylab="MPG", names=c("automatic","manual"),cex.lab=1.5)   
            } else if (input$para=='# of cylinders') {
            boxplot(mpg~cyl,data=ndata, col=c("red3","blue3","green3"), xlab="number of cylinders",ylab="MPG",names=c("4","6","8"),cex.lab=1.5)     
            } else if (input$para=='horsepower') {
            plot(ndata$hp,ndata$mpg,col="blue3",pch=19, cex=1.4, ylab="MPG",xlab="horsepower",cex.lab=1.5)   
            } else 
            plot(ndata$wt,ndata$mpg,col="red3",pch=19, cex=1.4,ylab="MPG",xlab="weight (lb/1000)",cex.lab=1.5)        
      }, height=400)
      
      # Predict MPG based on input value
      # convert raw input into readable varabiels
      # convert transmission type into 0 (auto) or 1 (manual)
    
      output$predmpg <- renderPrint({
            if (input$transtype =="auto") {
            nvar <- data.frame(am=as.factor("0"),cyl=as.factor(input$cyl),hp=input$hp,wt=input$wt) 
            cat(predict(fit4,nvar))
            } else {
            nvar <- data.frame(am=as.factor("1"),cyl=as.factor(input$cyl),hp=input$hp,wt=input$wt)       
            cat(predict(fit4,nvar))
            }      
            })
      
}

### once you done, you can deploy your app by
### library(rsconnect)
### deployApp(appName = "courseraapp_ianking")