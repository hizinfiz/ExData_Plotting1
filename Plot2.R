# Read in the text file
homePower <- read.table("household_power_consumption.txt", sep=";")
# Assign the approriate names and get rid of the first row
names(homePower) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_indensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
homePower <- homePower[2:2075260,]

# Change the first column to date
homePower[,1] <- as.Date(homePower[,1], format="%d/%m/%Y")
# Get only rows where the date is either Feb 01, 2007 or Feb 02, 2007
homePower <- homePower[format(homePower[,1], "%d/%m/%Y") == "01/02/2007" | format(homePower[,1], "%d/%m/%Y") == "02/02/2007",]

# Convert from factor to numeric
homePower[,3] <- as.numeric(as.character(homePower[,3]))

# Convert from factor to time
homePower[,2] <- as.character(homePower[,2])
homePower[,2] <- paste(homePower[,1], "PST", homePower[,2])
homePower[,2] <- as.POSIXct(homePower[,2], format="%Y-%m-%d PST %H:%M:%S")

# Plot line graph
plot(homePower$Time, homePower$Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(homePower$Time, homePower$Global_active_power)