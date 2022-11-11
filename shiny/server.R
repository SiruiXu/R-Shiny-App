#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# check
library(shiny)
library(plotly)
library(tidyverse)
library(medicaldata)
#data(package = "medicaldata")
sp <- medicaldata::smartpill



#load data



# Define server logic required to draw a line plot
shinyServer(function(input, output) {
  # describe data
  output$description <- renderText({
    
    "This study assessed gastric emptying, small bowel transit time, and total intestinal transit time in eight 
    trauma patients who were severely ill.
    These results were compared to those obtained in a different study involving 87 healthy participants.
    For this data analysis, we are investigating the conditions of Colonic Transit Time, Small Bowel Transit Time, and 
    Gastric	Emptying Time in different races."
  })
  
  # text for plot 1
  output$text1 <- renderText({
    "This panel is discussing the relationship of Small	Bowel	Transit Time vs Age acorss Races. 
      For example, When checking the box white, we can observe the  Small	Bowel	Transit Time for all the ages within white race."
  })
  
  output$Plot <- renderPlotly({
    
    
    
    # clean data
    sp <- sp %>%
      mutate(
        Race = recode(as.character(Race), "1" = "White", "2" = "Black",
                      "3" = "Asian/Pacific Islander", "4" = "Hispanic", "5" = "Other")
      ) %>% filter(Race %in% input$Race)
    # drop missing data
    sp_clean_1 <- sp %>% drop_na(Age)  %>% drop_na(Race) %>% drop_na(SB.Time) %>%  filter(Age<60)
    
    
    # generate plot
    ggplot_plot  <- ggplot(data = sp_clean_1,
                           aes(x = Age,
                               y = SB.Time,
                               color = Race)) +
      geom_line(size = 2) +
      labs(x = "Age",
           y ="SB Time",
           title="Line Plot of Small	Bowel	Transit Time vs Age acorss Races")
    ggplotly(ggplot_plot)
  })
  
  ## Plot 2
  # text for plot 2
  output$text2 <- renderText({
    "This panel is discussing the relationship of average Gastric	Emptying	Time acorss Races. 
      For example, When checking the box white, we can observe the  average Gastric	Emptying	Time for white race."
  })
  
  # clean data
  output$Plot2 <- renderPlotly({
    sp <- sp %>%
      mutate(
        Race = recode(as.character(Race), "1" = "White", "2" = "Black",
                      "3" = "Asian/Pacific Islander", "4" = "Hispanic", "5" = "Other")
      )  
    
    # drop missing data
    sp_clean_2 <- sp %>% drop_na(GE.Time)  %>% drop_na(Race) 
    sp_clean_2  <- sp_clean_2 %>%
      group_by(Race) %>%
      summarize(Average_GE_Time = mean(GE.Time)) %>% filter(Race %in% input$Race)
    
    # generate plot
    ggplot2 <- ggplot(data = sp_clean_2,
                      aes(x = Race,
                          y = Average_GE_Time,
                          fill = Race)) +
      geom_bar(stat="identity")+
      labs(x = "Race",
           y ="Average_GE_Time",
           title="Bar Plot of Average GE Time acorss Races")
    theme_minimal()
    ggplotly(ggplot2)
  })
  
  ## Plot 3
  # text for plot 3
  output$text3 <- renderText({
    "This panel is discussing the relationship of average Colonic	Transit	Time acorss Races. 
    For example, When checking the box white, we can observe the average Colonic	Transit	Time for white race."
  })
  
  output$Plot3 <- renderPlotly({
    sp <- sp %>%
      mutate(
        Race = recode(as.character(Race), "1" = "White", "2" = "Black",
                      "3" = "Asian/Pacific Islander", "4" = "Hispanic", "5" = "Other")
      )
    
    sp_clean_3 <- sp %>% drop_na(C.Time)  %>% drop_na(Race) 
    sp_clean_3  <- sp_clean_3 %>%
      group_by(Race) %>%
      summarize(Average_Colonic_Transit_Time= mean(C.Time)) %>% filter(Race %in% input$Race)
    # generate plot     
    ggplot3 <- ggplot(data = sp_clean_3,
                      aes(x = Race,
                          y = Average_Colonic_Transit_Time,
                          fill = Race)) +
      geom_bar(stat="identity")+
      labs(x = "Race",
           y ="Average_Colonic_Transit_Time",
           title="Bar Plot of Average Colonic Transit Time acorss Races")+
      theme_minimal()
    
    ggplotly(ggplot3)
  })
  
})


