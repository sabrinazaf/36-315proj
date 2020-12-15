#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
l
library(shiny)
# first-app-5.R
#next, app-6R 
#next, wordplot
#next, wordplot
header <- dashboardHeader(title="Exploring The Office")
# Define UI for application that draws a histogram
sidebar <-  dashboardSidebar(
    sidebarMenu(
        menuItem("Introduction", tabName = "intro", icon = icon("dashboard")),
        menuItem("Histogram of Lines By Season", tabName = "partB", icon = icon("th")),
        menuItem("Histogram of IMDb Rating of Episodes by Director", tabName="partC", icon=("th")),
        menuItem("WordCloud of Most Common Words in the Office",tabName="partD", icon=("th")),
        menuItem("Tree of Episodes and Seasons of The Office", tabname="partE",icon=("th")),
        menuItem("x",tabName="PartE", icon=("th")),
        menuItem("y",tabName="PartF", icon=("th")),
        menuItem("z",tabName="PartG",icon=("th")),
        menuItem("a",tabName = "A",icon=("th"))
        
    )
)
body <- dashboardBody(
        tabItems(















dashboardPage(skin="teal",header, sidebar, body)
