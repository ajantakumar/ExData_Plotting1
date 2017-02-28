# This script reads in the household energy usage data, subsets the 2-day period being analyzed,
# creates a line plot for 3 types of sub_metering data and writes the graph to a PNG file.

# Read in the data to 'energy' table.  Assumes the data is in the working directory.
energy <- read.table("household_power_consumption.txt",sep=";",header=TRUE,fill=TRUE)

# Retain only the Date and Global Active Power columns.  Convert them to character and numeric.
energy <- energy[,c(1,2,7:9)]
energy$Date <- as.character(energy$Date)
energy$Time <- as.character(energy$Time)
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

# Write the plot to the file "plot3.png"

png("plot3.png",width=480,height=480)

# Create the plot frame
plot(energy_sub$DateTime, energy_sub$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")

# Add lines for each of the Sub_metering data vectors
lines(energy_sub$DateTime, energy_sub$Sub_metering_1,col="black",type="l")
lines(energy_sub$DateTime, energy_sub$Sub_metering_2,col="red",type="l")
lines(energy_sub$DateTime, energy_sub$Sub_metering_3,col="blue",type="l")

# Add a legend in the top right corner
legend("topright",c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"),col=c("black","red","blue"),lty=c(1,1,1),lwd=c(2,2,2))

# Close the graphic device
dev.off()

# Remove data frame from memory
rm(energy_sub)





