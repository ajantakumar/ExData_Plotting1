# This script reads in the household energy usage data, subsets the 2-day period being analyzed,
# creates a histogram for Global Active Power and writes the graph to a PNG file.

# Read in the data to 'energy' table.  Assumes the data is in the working directory.
energy <- read.table("household_power_consumption.txt",sep=";",header=TRUE,fill=TRUE)

# Retain only the Date and Global Active Power columns.  Convert them to character and numeric.
energy <- energy[,c(1,3)]
energy$Date <- as.character(energy$Date)
energy$Global_active_power <- as.numeric(as.character(energy$Global_active_power))

# Filter the data for the 2-day period to be analyzed, Feb 1-2, 2007. Put in 'energy_sub' table.
energy_sub <- energy[energy$Date %in% c('1/2/2007','2/2/2007'),]

# Remove the 'energy' table to release memory
rm(energy)

#Initialize png file
png("plot1.png",width=480,height=480)

# Create the histogram
hist(energy_sub$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency")

dev.off()

# Remove 'energy_sub' to release memory
rm(energy_sub)
