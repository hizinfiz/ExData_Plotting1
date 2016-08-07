# Read in the text file
homePower <- read.table("household_power_consumption.txt", sep=";")
# Assign the approriate names and get rid of the first row
names(homePower) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_indensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
homePower <- homePower[2:2075260,]

# Change the first column to date
homePower[,1] <- as.Date(homePower[,1], format="%d/%m/%Y")
# Get only rows where the date is either Feb 01, 2007 or Feb 02, 2007
homePower <- homePower[format(homePower[,1], "%d/%m/%Y") == "01/02/2007" | format(homePower[,1], "%d/%m/%Y") == "02/02/2007",]

# Convert from factor to time
homePower[,2] <- as.character(homePower[,2])
homePower[,2] <- paste(homePower[,1], "PST", homePower[,2])
homePower[,2] <- as.POSIXct(homePower[,2], format="%Y-%m-%d PST %H:%M:%S")

# Convert from factor to numeric
homePower[,3] <- as.numeric(as.character(homePower[,3]))
homePower[,7] <- as.numeric(as.character(homePower[,7]))
homePower[,8] <- as.numeric(as.character(homePower[,8]))
homePower[,9] <- as.numeric(as.character(homePower[,9]))

# Plot line graphs
plot(homePower$Time, homePower$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(homePower$Time, homePower$Sub_metering_1)
lines(homePower$Time, homePower$Sub_metering_2, col="red")
lines(homePower$Time, homePower$Sub_metering_3, col="blue")

# Add legend
legend("topright", lwd=2, col=c("black", "blue", "red"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
