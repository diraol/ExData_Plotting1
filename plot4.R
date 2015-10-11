# Copyright (C) 2015, Diego Rabatone Oliveira
#
# This is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This code is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this code. If not, see <http://www.gnu.org/licenses/>.

# Setting local language to english instead of portguese:
Sys.setlocale("LC_TIME","C")

# Reading data
#  Before executing the script, download the zip file from
#  https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#  and unzip it on the folder where this script is saved.
data = read.table('household_power_consumption.txt', header=TRUE, sep=';', na.strings="?")

# Merging Date and Time variables
data$DT <- paste(data$Date, data$Time, sep=' ')

# Converting the DT string into a Date/Time field
data$DT <- strptime(data$DT, format='%d/%m/%Y %H:%M:%S')

# Filtering the required 2 days that will be analysed
filtered_data <- data[data$DT >= '2007-02-01' & data$DT < '2007-02-03', ]
# Creating weekdays data
filtered_data$dia_da_semana <- weekdays(filtered_data$DT)

#Opening PNG device; create 'plot4.png' in my working directory
png(file = "plot4.png")
# Defining a 2x2 grid for plots on one page
par(mfrow=c(2,2))
# Plot 1
plot(filtered_data$DT, filtered_data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
# Plot 2
plot(filtered_data$DT, filtered_data$Voltage, type="l", xlab="datetime", ylab="Voltage")
# Plot 3 - Base graph
plot(filtered_data$DT, filtered_data$Sub_metering_1, type="l",xlab="",ylab="Energy sub metering")
# Adding one line to the plot3
lines(filtered_data$DT, filtered_data$Sub_metering_2, col='red', type="l",xlab="",ylab="")
# Adding one more line to the plot3
lines(filtered_data$DT, filtered_data$Sub_metering_3, col='blue', type="l",xlab="",ylab="")
# Adding legend plot3
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
        lty=1, col=c('black', 'red', 'blue'), bty='n', cex=.75)

# Plot 4
plot(filtered_data$DT,
     filtered_data$Global_reactive_power,
     type="l",
     xlab="",
     ylab="Global_reactive_power")

#Closing de the PNG device
dev.off()