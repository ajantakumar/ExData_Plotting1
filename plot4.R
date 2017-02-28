# This script reads in the household energy usage data, subsets the 2-day period being analyzed,
# creates a histogram for Global Active Power and writes the graph to a PNG file.

# Read in the data to 'energy' table.  Assumes the data is in the working directory.
energy <- read.table("household_power_consumption.txt",sep=";",header=TRUE,fill=TRUE)


# Convert needed columns from factor data to character or numeric data
energy$Date <- as.character(energy$Date)
energy$Time <- as.character(energy$Time)
energy$Global_active_power <- as.numeric(as.character(energy$Global_active_power))
energy$Global_reactive_power <- as.numeric(as.character(energy$Global_reactive_power))
energy$Voltage <- as.numeric(as.character(energy$Voltage))
energy$Sub_metering_1 <- as.numeric(as.character(energy$Sub_metering_1))
energy$Sub_metering_2 <- as.numeric(as.character(energy$Sub_metering_2))
energy$Sub_metering_3 <- as.numeric(as.character(energy$Sub_metering_3))

# Filter the data for the 2-day period to be analyzed, Feb 1-2, 2007. Put in 'energy_sub' table.
energy_sub <- energy[energy$Date %in% c('1/2/2007','2/2/2007'),]

# Remove the 'energy' table to release memory
rm(energy)

# Concatenate the date and time strings.  Convert to POSIXlt format
energy_sub$DateTime <- paste(energy_sub$Date,energy_sub$Time)
energy_sub$DateTime <-  strptime(energy_sub$DateTime, "%d/%m/%Y %H:%M:%S")

# Write the plot to the file, plot4.png

png("plot4.png",width=480,height=480)

par(mfrow=c(2,2))

# Create the line plot of DateTime vs. Global Active Power with axis labels
plot(energy_sub$DateTime, energy_sub$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Create the line plot of DateTime vs. Voltage with axis labels
plot(energy_sub$DateTime, energy_sub$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Create the Energy submetering plot

# Create the plot frame
plot(energy_sub$DateTime, energy_sub$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")

# Add lines for each of the Sub_metering data vectors
lines(energy_sub$DateTime, energy_sub$Sub_metering_1,col="black",type="l")
lines(energy_sub$DateTime, energy_sub$Sub_metering_2,col="red",type="l")
lines(energy_sub$DateTime, energy_sub$Sub_metering_3,col="blue",type="l")

# Add a legend in the top right corner
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),bty="n",lty=c(1,1,1),lwd=c(2,2,2))

# Create the line plot of DateTime vs. Voltage with axis labels
plot(energy_sub$DateTime, energy_sub$Global_reactive_power, type="l", xlab="datetime", ylab="Globa_reactive_power")

dev.off()
rm(energy_sub)
