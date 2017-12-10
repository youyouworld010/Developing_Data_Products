
# The fuel economy datasets contains a subset of the fuel economy data that the EPA makes 
# available on http://fueleconomy.gov. It contains only models which had a new release every 
# year between 1999 and 2008 - this was used as a proxy for the popularity of the car.
#
# This app provided users a tool to explore the relationship between a car's fuel efficiency 
# on the highway, in miles per gallon and a car's engine size, in liters for different types 
# of cars.

library(shiny); library(tidyverse)

shinyUI(fluidPage(
        
  titlePanel("Explore the Relationship between Highway Fuel Efficiency, Car Type and Engine Size"),
  
  sidebarLayout(
    sidebarPanel(
       h4("Instructions on How to Use this App"),
       h5("This app lets users explore the relationship between highway fuel efficiency, car type
          and engine size. Users can select a car type from the drop-down menu and slide the slider
          to select the engine size. If users want to see the predicted highway fuel efficiency
          of the car, they can check the textbox next to 'Show/Hide Prediction Result'. Then click the 
          'Submit' button. The graph will show a regression line for the selected type of the car.
          A blue dot reflected the engine size and the predicted highway fuel efficiency. The prediction
          result will also show under the graph if the textbox was checked."),
       selectInput("variable", "Select a Car Type:", 
                   c("Two-seat Sports Car" = "2seater",
                     "Compact Car" = "compact",
                     "Midsize Car" = "midsize",
                     "Minivan" = "minivan",
                     "Pickup Truck" = "pickup",
                     "Subcompact Car" = "subcompact",
                     "SUV" = "suv")),
       sliderInput("engine",
                   "Slide to Select the Size of Engine (in Liters):",
                   min = 1,
                   max = 7,
                   value = 3, step = 0.1),
       checkboxInput("showpred", "Show/Hide Prediction Result", value = T),
       submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        plotOutput("plot1"),
        h3("Predicted Highway Fuel Efficiency From the Model:"),
        textOutput("pred1")
    )
  )
))
