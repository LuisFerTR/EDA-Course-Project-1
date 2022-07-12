library(dplyr) # mutate

# Load data
data <- read.table("household_power_consumption.txt", stringsAsFactors = FALSE,
                   skip = 66637, nrows = 2880, na.strings = "?", sep = ";")

# Assign variables name
variables <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
               "Global_intensity","Sub_metering_1", "Sub_metering_2","Sub_metering_3")
names(data) <- variables

date.time <- paste(data$Date, data$Time)

data <- mutate(data, Date = as.Date(Date, format = "%d/%m/%Y"), 
               Time = strptime(date.time, "%d/%m/%Y %H:%M:%S"))

# Open Grpahic file device
png(filename = "plot3.png")

with(data, plot(y=Sub_metering_1, x=Time, type = "l", ylab = "Energy Sub Metering"))
with(data, lines(y=Sub_metering_2, x=Time, col = "Red"))
with(data, lines(y=Sub_metering_3, x=Time, col = "Dodgerblue3"))
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "Dodgerblue3"), 
       lwd = 1)

# Close Grpahic file device
dev.off()