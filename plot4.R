
## load the data from the zipped data file

HouseholdPowerConsumption<-read.table(unz("./exdata-data-household_power_consumption.zip","household_power_consumption.txt"), sep=";", header=TRUE, na.strings="?",colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric"))

## get only the data for the correct dates
CorrectDates<-HouseholdPowerConsumption$Date=="2/2/2007" | HouseholdPowerConsumption$Date=="1/2/2007"
PowerData<-HouseholdPowerConsumption[CorrectDates,]

## combine the date and text fields into a single date/time
PowerData$DateTimeText<-paste(PowerData$Date,PowerData$Time,sep="-")
PowerData$DateTimeValue<-strptime(PowerData$DateTimeText, format="%d/%m/%Y-%H:%M:%S")






## create the png file of the right name and size
png("./plot4.png", width=480, height=480)
## set the canvass so we can fit four charts on it
par(mfrow=c(2,2))

## plot the first line chart
plot(PowerData$DateTimeValue,PowerData$Global_active_power, ylab="Global Active Power (kilowatts)", xlab="", type="n")
## put the lines on rather than showing open circles for points
lines(PowerData$DateTimeValue,PowerData$Global_active_power, type="l")

## plot the second line chart
plot(PowerData$DateTimeValue,PowerData$Voltage, ylab="Voltage", xlab="datetime", type="n")
## put the lines on rather than showing open circles for points
lines(PowerData$DateTimeValue,PowerData$Voltage, type="l")

## plot the third line chart
plot(range(PowerData$DateTimeValue),range(PowerData$Sub_metering_1), type="n", ylab="Energy sub metering", xlab="",yaxt="n")
## create the custom y axis
axis(2,at=seq(0,40, by=10))
## put on the three lines
lines(PowerData$DateTimeValue,PowerData$Sub_metering_1, col="black", type="l")
lines(PowerData$DateTimeValue,PowerData$Sub_metering_2, col="red", type="l")
lines(PowerData$DateTimeValue,PowerData$Sub_metering_3, col="blue", type="l")
## add the legend
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1))


## plot the fourth line chart
plot(PowerData$DateTimeValue,PowerData$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="n", yaxt="n")
## create the custom y axis
axis(2,at=seq(0,0.5, by=0.1))
## put the lines on rather than showing open circles for points
lines(PowerData$DateTimeValue,PowerData$Global_reactive_power, type="l")

dev.off()


