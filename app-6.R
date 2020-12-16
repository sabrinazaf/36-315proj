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
    titlePanel("Histogram of Episode Ratings"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        checkboxInput("Second Variable", label = "Fill By Director", value = TRUE)
        , 

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
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
}

# Run the application 
shinyApp(ui = ui, server = server)
