# This script reads in the household energy usage data, subsets the 2-day period being analyzed,
# creates a line plot for DateTime vs Global Active Power and writes the graph to a PNG file.

# Read in the data to 'energy' table.  Assumes the data is in the working directory.
energy <- read.table("household_power_consumption.txt",sep=";",header=TRUE,fill=TRUE)

# Retain only the Date and Global Active Power columns.  Convert them to character and numeric.
energy <- energy[,c(1:3)]
energy$Date <- as.character(energy$Date)
energy$Time <- as.character(energy$Time)
energy$Global_active_power <- as.numeric(as.character(energy$Global_active_power))

# Filter the data for the 2-day period to be analyzed, Feb 1-2, 2007. Put in 'energy_sub' table.
energy_sub <- energy[energy$Date %in% c('1/2/2007','2/2/2007'),]

# Remove the 'energy' table to release memory
rm(energy)

# Concatenate the date and time strings.  Convert to POSIXlt format
energy_sub$DateTime <- paste(energy_sub$Date,energy_sub$Time)
energy_sub$DateTime <-  strptime(energy_sub$DateTime, "%d/%m/%Y %H:%M:%S")

#Initialize png file

png("plot2.png",width=480,height=480)

# Create the line plot of DateTime vs. Global Active Power with axis labels
plot(energy_sub$DateTime, energy_sub$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# Write the plot to a file
dev.off()

# Remove 'energy_sub' to release memory
rm(energy_sub)


