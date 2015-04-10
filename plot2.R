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

plot2 <- function() {
        
        ## This should all be automated, so first we'll use importdata
        
        data <- importdata()
        
        png("plot2.png", width=480, height=480)        ## Then we'll open the plot
        
        ## Plot #2 is a line graph of Global_active_power over two days
        
        plot(
                x = data$Date.Time,             ## Time on x xais
                y = data$Global_active_power,   ## GAP on y axis
                xlab = "",                      ## Force blank x axis
                ylab = "Global Active Power (kilowatts)",       # y label
                type = "l",                     ## create line plot
                main = ""                       ## no title
        )
        
        dev.off()               ## Close the device
        
        print("Plot complete: plot2.png")
        
}

## -------------------------------------------------------------

## That's it. Thank you!