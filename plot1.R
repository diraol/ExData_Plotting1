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
# along with this code.  If not, see <http://www.gnu.org/licenses/>.

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

#Opening PNG device; create 'plot1.png' in my working directory
png(file = "plot1.png")
#Drawing the Histogram
hist(as.numeric(filtered_data$Global_active_power), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
#Closing de the PNG device
dev.off()