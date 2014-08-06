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
# Plot 1
####################################################################################################################################### 

# Launch PNG Graphics device
png(file="plot1.png", width = 480, height = 480)

# Call the histogram plotting function
with(data, hist(Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red"))

# Close Graphics Device
dev.off()


