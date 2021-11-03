#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer( function( input, output ) {

        # pick the security based on input$Security from ui.R
      start1 <- Sys.time()
      
      silentLoad <- function( mylib ){ # make messages and warnings silent.
        options( warn = -1 ) # suppress warnings. 
        suppressPackageStartupMessages( mylib ) # Supress messages. 
      }
      silentLoad( library( data.table ) )
      silentLoad( library( dplyr ) )
      silentLoad( library( R.utils ) )
      silentLoad( library( stats ) )
      silentLoad( library( ggplot2 ) )
      
        MonthlyReturns <- fread( "BetaFileRe.csv", header=TRUE, sep="," )
        #str( MonthlyReturns )
        namesRaw <- names( MonthlyReturns )
        namesMap <- c( "S&P500", "Dollar Index", "Nasdaq100", "Dow Jones Index", "Treasury Bill 10 Years", "Treasury Bill 5 Years","Treasury Bill 30 Years", "Apple Shares" )
        
        SecNameRawFR <- reactive({
                    namesRaw[ input$Security+13 ]
                    #print( input$Security+13 )
        })
        
        SecNameFR <- reactive({
                    namesMap[ input$Security ]
                    #print( input$Security )
        })
        
        dynamicLM <- function( df, var ){
          fm <- as.formula( paste( var, "~", colnames(df)[14] ))
          cat( "Line 151: formula" )
          print( fm )
          lm( fm, data = df )
        }
        
        output$BetaPlot <- renderPlot({
            sliderInput <- input$Security #slider input range 2 to 8. Take 2 now.
            index <- sliderInput + 13 # index into monthly returns.
          
            myvar <- namesRaw[index]
            cat("\n Line 159: ", myvar, "\n")
            BetaModel <- dynamicLM( MonthlyReturns, myvar)
            
            output$BetaCoef <- renderText( {
                    BetaModel$coefficients[2]
            })
            
            predicted_df <- data.frame( secPred = predict( BetaModel, MonthlyReturns), SP500Re=MonthlyReturns$SP500Re )
            print( summary( BetaModel ) )
            cat("\n")
          
            #myGraphName <- paste("Week4P1Graph",input,"0.png",sep="")
            myTitle <- paste( myvar," vs S&P500", sep="")
            #png( myGraphName, width = 700, height = 700, unit = "px" )
            #define names for the variables.
            yvariable <- names(MonthlyReturns)[index]
            print( yvariable )
            xstring <- "SP500Re"
            ystring <- yvariable
            tempggplot <- ggplot( MonthlyReturns ) + 
                #scale_y_continuous( limits = c( 0, 2.5), name="Rolling Beta AAPL vs S$P500") +
                geom_point( aes_string( x = xstring, y = ystring ), size=0.5 )+
                #geom_line( aes( x = xids, y = AllBetas[,3], color = "5Y rolling"), size=0.5)+
                #geom_line( aes( x = xids, y = AllBetas[,4], color = "7Y rolling"), size=0.5)+
                #geom_line( aes( x = xids, y = AllBetas[,5], color = "10Y rolling"), size=0.5)+
                #geom_point( aes( x = xids[ length(xids) ], y = 1.23, color = "Yahoo 5Y Beta", color="black" ), size = 10, shape = 4, stroke = 3 )+
                geom_line(color='red',data = predicted_df, aes(y=secPred, x=SP500Re))+
                ggtitle( myTitle, subtitle = "monthly returns.")+
                theme( legend.position="bottom", plot.title = element_text(size = 30, hjust = 0.5),
                       plot.subtitle = element_text( size = 20, hjust = 0.5 ) )
            tempggplot
        })
        
        #Output: 
        output$SecNameRaw <- renderText( {
          SecNameRawFR()
        })
        
        output$SecName <- renderText( {
          SecNameFR()
        })
          
          #print( tempggplot ) 
          #dev.off()
        stop1 <- Sys.time()
        
        cat( "\nTime Summary:\n" )
        Time1 <- stop1 - start1
        Time1 <- format(round( Time1, 2 ), nsmall = 2)
        cat( "Library Loading : ", Time1 )
        cat( "\n" )
})

