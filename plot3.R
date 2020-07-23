#' # Exploratory Data Analysis
#' 
#' Link to dataset and its description from UCI:
#' 
#' https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#' 
#' https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
#' 
#' Variable names for reference: 
#' 
# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.
#'
#' Loading and Cleaning Data
df = read.table("household_power_consumption.txt", 
                header=T, 
                sep=";", 
                na.strings = "?", 
                colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
# View(df)
# typeof(df$Date)
df$Date = as.Date(df$Date,"%d/%m/%Y")

# subset data from the dates 2007-02-01 and 2007-02-02
df = subset(df,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
df = na.omit(df)
any(is.na(df))

# combine Date and Time column to give DateTime as a whole
df$DateTime = as.POSIXct(paste(df$Date,df$Time))
#'
#' ## Plot 3

png("plot3.png", width=480, height=480)

plot(df$DateTime,df$Sub_metering_1,
     xlab = "",ylab = "Energy Sub Metering",
     type = "l",col = 'black')
lines(df$Sub_metering_2 ~ df$DateTime, col="red")
lines(df$Sub_metering_3 ~ df$DateTime,col="blue")
legend("topright",col = c("black","red","blue"),
       lwd=c(1,1,1),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
