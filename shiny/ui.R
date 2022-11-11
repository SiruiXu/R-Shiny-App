#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#check sd


library(shiny)
library(plotly)

#load data
#install.packages("medicaldata")
#library(medicaldata)
#data(package = "medicaldata")
#sp <- medicaldata::smartpill

Race <- c("White","Black",
          "Asian/Pacific Islander", "Hispanic", "Other")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Smart Pill Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(inputId = "Race", label = "Race to Disaply",
                         sort(Race),
                         selected = c('White','Black',"Asian/Pacific Islander", "Hispanic", "Other"))
    ),
    
    mainPanel(
      textOutput("description"),  ## add description for data
      tabsetPanel(
        # add titles
        tabPanel(title = "Line Plot of Small	Bowel	Transit Time vs Age acorss Races",
                 plotlyOutput("Plot"),
                 textOutput("text1")),
        tabPanel(title = "Bar Plot of Average GE Time acorss Races",
                 plotlyOutput("Plot2"),
                 textOutput("text2")), 
        tabPanel(title = "Bar Plot of Average Colonic Transit Time acorss Races",
                 plotlyOutput("Plot3"),
                 textOutput("text3"))
      )
      
    ) 
  )
)
)