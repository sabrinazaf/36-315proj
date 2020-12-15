#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(schrute)
library(ggplot2)
library(shiny)
library(dplyr)
library(shinydashboard)
library(datasets)
library(tidyverse)
library(plotly)
library(wordcloud)
library(wordcloud2)
library(htmlwidgets)

# Define server logic required to draw a histogram
function(input, output) {

    ##Andrew's Plot 1 (app-5.R)   
    cbp <- c("#999999", "#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", 
             "#0072B2", "#D55E00", "#CC79A7")
    schrute <- schrute::theoffice
    charlines <- table(schrute$character)
    charlines <- charlines[charlines > 40]
    charnames <- names(charlines)
    schrute <- schrute[which(schrute$character %in% charnames),]
    schrute$season <- as.factor(schrute$season)
    schrute$character <- as.factor(schrute$character)
    output$distPlot <- renderPlot({
        if (input$`Second Variable`){
            ggplot2::ggplot(schrute, mapping = ggplot2::aes(x = reorder(character, character, function(x) -length(x)), 
                                                            y = season,
                                                            fill = season)) +
                ggplot2::geom_bar(position = "stack", stat = "identity") + 
                ggplot2::labs(x = "Character Lines By Season", y = "Count") + 
                ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, 
                                                                   hjust = 1, 
                                                                   vjust = 0.5))
        } else {
            ggplot2::ggplot(schrute, mapping = ggplot2::aes(x = reorder(character, character, function(x) -length(x)),
                                                            y = season)) +
                ggplot2::geom_bar(position = "stack", stat = "identity", 
                                  fill = "black") + 
                ggplot2::labs(x = "Character Lines", y = "Count") + 
                ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, 
                                                                   hjust = 1, 
                                                                   vjust = 0.5))
        }
        
    })
    ## Andrew's Second Plot (app-6.R)
    schrute <- schrute::theoffice
    schrute <- subset(schrute, !duplicated(subset(schrute, select=c(season, episode))))
    schrute <- schrute[unsplit(table(schrute$director), schrute$director) > 2, ]
    output$distPlot <- renderPlot({
        if (input$`Second Variable`){
            ggplot2::ggplot(schrute, mapping = ggplot2::aes(x = imdb_rating, fill = director)) +
                ggplot2::geom_histogram(binwidth = .3) + 
                ggplot2::labs(x = "IMDB Rating", y = "Count")
        } else {
            ggplot2::ggplot(schrute, mapping = ggplot2::aes(x = imdb_rating)) +
                ggplot2::geom_histogram(binwidth = .3, fill = "black") + 
                ggplot2::labs(x = "IMDB Rating", y = "Count")
        }
        
    })
## My Word Cloud 
    
    output$wordcloud2 <- renderWordcloud2({
        # wordcloud2(demoFreqC, size=input$size)
        wordcloud2(demoFreq, size=input$size)
    })
## My tree 
}
    

}
