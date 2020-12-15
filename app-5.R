#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("How Many Lines Did Each Character Have?"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        checkboxInput("Second Variable", label = "Fill By Season", value = TRUE)
        , 
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
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
}

# Run the application 
shinyApp(ui = ui, server = server)
