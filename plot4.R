#######################################################################################################################################  
# 	Install and load Necessary Libraries
####################################################################################################################################### 
# install.packages("lubridate")
library(lubridate)

#######################################################################################################################################  
# 	Read in Data
####################################################################################################################################### 

# Read in the first five rows to determine column classes and starting date
initial 	<- read.table("household_power_consumption.txt", header = TRUE, nrows = 5, sep=";")
classes  	<- sapply(initial, class)

# Use lubritate functions to extract dates and times
data_start 	<- dmy_hms(paste(initial[1, "Date"], initial[1, "Time"]))

# Set the dates we are interested in looking at
start_date 	<- ymd_hms("2007-02-01 00:00:00")
end_date 	<- ymd_hms("2007-02-02 23:59:59")

# Calculate the number of minutes from the start of data to the first recording we are interested in
skip_mins <- as.numeric((start_date - data_start ) / eminutes(1))+1
# Calculate the number of minutes from our start to end date i.e. the number of rows we are interested in
no_rows   <- as.numeric((end_date - start_date) / eminutes(1))+1

# Read in data -  Specify column classes to speed up processing
data 	<- read.table("household_power_consumption.txt", header = FALSE, skip=skip_mins, nrows=no_rows, sep=";", col.names=names(initial), colClasses = classes, na.strings="?")


#######################################################################################################################################  
# Plot 4
####################################################################################################################################### 

# Launch PNG Graphics device
png(file="plot4.png", width = 480, height = 480)

# Set up gridsize to 2x2
par(mfrow=c(2,2))

## Graph 1 ##
with(data, plot(x=dmy_hms(paste(Date, Time)), Global_active_power, type="l", ylab="Global Active Power", xlab=""))

## Graph 2 ##
with(data, plot(x=dmy_hms(paste(Date, Time)), Voltage, type="l", ylab="Voltage", xlab="datetime"))

## Graph 3 ##
with(data,  plot(x=dmy_hms(paste(Date, Time)), Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
with(data, lines(x=dmy_hms(paste(Date, Time)), Sub_metering_2, col="red", type="l"))
with(data, lines(x=dmy_hms(paste(Date, Time)), Sub_metering_3, col="blue", type="l"))
legend("topright", bty = "n", lty=1, col=c("black", "blue", "red"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Graph 4 ##
with(data, plot(x=dmy_hms(paste(Date, Time)), Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime"))

# Close Graphics Device
dev.off()


