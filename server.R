#
# In the server, a linear model that predicted highway fuel efficiency from the car type and 
# engine size was fitted. A regression line based on users' input of car type was also drawn 
# on the graph. At the end, the prediction result will or will not show under the graph 
# depends on whether the users want to see them or not.

library(shiny); library(tidyverse)

shinyServer(function(input, output){
        model <- lm(hwy ~ class + displ, data = mpg)
        coef <- summary(model)$coefficients
        pred <- reactive({
                classinput <- input$variable
                engineinput <- input$engine
                predict(model, newdata = data.frame(class = classinput, 
                                                    displ = engineinput))
        })
        
        output$plot1 <- renderPlot({
                engineinput <- input$engine
                if(input$variable == "2seater"){ggplot(data = mpg) +
                                geom_point(mapping = aes(x = displ, y = hwy, color = class)) +
                                geom_abline(slope = coef[8,1], intercept = coef[1,1]) +
                                geom_point(x = input$engine, y = pred(), color = "blue", size = 4) +
                                xlab("Engine Size") + ylab("Highway Fuel Efficiency")
                } else if(input$variable == "compact"){ggplot(data = mpg) +
                                geom_point(mapping = aes(x = displ, y = hwy, color = class)) +
                                geom_abline(slope = coef[8,1], intercept = coef[1,1]+coef[2,1]) +
                                geom_point(x = input$engine, y = pred(), color = "blue", size = 4) +
                                xlab("Engine Size") + ylab("Highway Fuel Efficiency")
                } else if(input$variable == "midsize"){ggplot(data = mpg) +
                                geom_point(mapping = aes(x = displ, y = hwy, color = class)) +
                                geom_abline(slope = coef[8,1], intercept = coef[1,1]+coef[3,1]) +
                                geom_point(x = input$engine, y = pred(), color = "blue", size = 4)  +
                                xlab("Engine Size") + ylab("Highway Fuel Efficiency")
                } else if(input$variable == "minivan"){ggplot(data = mpg) +
                                geom_point(mapping = aes(x = displ, y = hwy, color = class)) +
                                geom_abline(slope = coef[8,1], intercept = coef[1,1]+coef[4,1]) +
                                geom_point(x = input$engine, y = pred(), color = "blue", size = 4) +
                                xlab("Engine Size") + ylab("Highway Fuel Efficiency")
                } else if(input$variable == "pickup"){ggplot(data = mpg) +
                                geom_point(mapping = aes(x = displ, y = hwy, color = class)) +
                                geom_abline(slope = coef[8,1], intercept = coef[1,1]+coef[5,1]) +
                                geom_point(x = input$engine, y = pred(), color = "blue", size = 4) +
                                xlab("Engine Size") + ylab("Highway Fuel Efficiency")
                } else if(input$variable == "subcompact"){ggplot(data = mpg) +
                                geom_point(mapping = aes(x = displ, y = hwy, color = class)) +
                                geom_abline(slope = coef[8,1], intercept = coef[1,1]+coef[6,1]) +
                                geom_point(x = input$engine, y = pred(), color = "blue", size = 4) +
                                xlab("Engine Size") + ylab("Highway Fuel Efficiency")
                } else {ggplot(data = mpg) +
                                geom_point(mapping = aes(x = displ, y = hwy, color = class)) +
                                geom_abline(slope = coef[8,1], intercept = coef[1,1]+coef[7,1]) +
                                geom_point(x = input$engine, y = pred(), color = "blue", size = 4) +
                                xlab("Engine Size") + ylab("Highway Fuel Efficiency")
                }
        })
        output$pred1 <- renderText({
                if(input$showpred){
                        pred()
                } else{
                        return(NULL)
                }
        })
        
})
