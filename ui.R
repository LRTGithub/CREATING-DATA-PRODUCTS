#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Calculating Betas vs S&P500"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h1("Calculating Betas vs S&P500."),
            h1( "Slide to change security."),
            h2( "Monthly=20 session of S&P500, rolling daily."),
            em( h4( "Help file: you can get help on how to use this app in the file Week4P1Documentation.rd") ),
            sliderInput( "Security", "Security Id:", min = 2, max = 8, value = 5 )
        ),
    
      # Show a plot of the generated distribution
        mainPanel(
            plotOutput( "BetaPlot" ),
            h3( textOutput("SecName"), textOutput("SecNameRaw"), " Beta = ",textOutput("BetaCoef")  ),
            h3( "vs S&P500 Monthly returns + Regression line."),
            h3( "20 sessions rolling daily.")
        )
    )
))
