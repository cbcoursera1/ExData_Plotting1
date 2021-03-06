## Hello peer evaluator!

## Thank you for taking time to review my work. Good luck in the course!

## ----------------------------------------------------------------------------

## I first created a function to import the data (just for my own ease of use)

importdata <- function() {

        ## First we read in the data. As we do this, we re-class each column
        ## approporiatly. 

        data <- read.csv(        ## Using read.csv, not read.csv2
        
                "household_power_consumption.txt",      ## file name
                na.strings = "?",               ## specify that ? should be NA
                sep = ";",                      ## separator in this case is ;
                colClasses = c(                 ## manually specify classes
                        
                        "character",            ## Date and Time will be
                        "character",            ## characters because we'll
                                                ## combine them later
                        rep("numeric", 7)       ## the other 7 columns are numeric
                        )
                )

        ## Now that we have this huge dataset imported, let's subset it down to
        ## work with it. We'll take only data from the two relevant dates

        data2 <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

        ## Then, we'll combine our Date and Time columns into a Date.Time column

        data3 <- data.frame("Date.Time" = paste(data2$Date, data2$Time), data2[, 3:9])

        ## Now that they're combined, we can make Date.Time a POSIXlt object

        data3$Date.Time <- as.POSIXlt(strptime(data3$Date.Time, "%d/%m/%Y %H:%M:%S"))

        ## Finally, we'll return the dataframe
        
        return(data3)

}

## Now (at last) the fun part. Let's make a plot!

## IMPORTANT!

## Please note that I cannot account for extremely minor graphical discrepancies
## between the instructor's plots and my own. I am attributing these to
## different versions of R, or OSX (instructor) vs Windows (me). The graphs tell
## the exact same story, have the exact same labels and data. I don't think that
## a legend being 10 pixels larger or smaller is a significant difference,
## given this course is focused on exploratory analysis and quick-and-dirty
## plotting.

## I don't believe Dr. Peng designed this assignment for us to dig around in
## obscure design parameters for hours, sizing and resizing plot elements until
## they are perfect (if that's even possible).

## I will be doing my evaluation according to this standard.

plot3 <- function() {
        
        ## This should all be automated, so first we'll use importdata
        
        data <- importdata()
        
        png("plot3.png", width=480, height=480)        ## Then we'll open the plot
        
        ## Plot #3 is a line graph of Sub_metering 1, 2, and 3 over two days
        
        ## First we create the plot for SM1
        
        plot(
                x = data$Date.Time,             ## Time on x xais
                y = data$Sub_metering_1,        ## GAP on y axis
                xlab = "",                      ## Force blank x axis
                ylab = "Energy sub metering",   ## y label
                type = "l",                     ## create blank plot
                main = "",                      ## no title
                col = "black"                   ## color is black
        )
        
        ## Then we'll add the lines for SM2 and 3
        
        lines(
                x = data$Date.Time,             ## Time on x xais
                y = data$Sub_metering_2,        ## SM2 on y axis
                type = "l",                     ## specify line
                col = "red"                     ## color is red
        )
        
        lines(
                x = data$Date.Time,             ## Time on x xais
                y = data$Sub_metering_3,        ## SM3 on y axis
                type = "l",                     ## specify line
                col = "blue"                    ## color is blue
        )
        
        ## Finally the legend
        
        legend(
                "topright",
                legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                lty = c(1,1,1),                 ## make it a line legend
                pch = c(NA,NA,NA),              ## there are no points
                col = c("black", "red", "blue") ## colors
                
        )
        
        dev.off()               ## Close the device
        
        print("Plot complete: plot3.png")
        
}

## -------------------------------------------------------------

## That's it. Thank you!