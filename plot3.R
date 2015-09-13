
## load the data from the zipped data file

HouseholdPowerConsumption<-read.table(unz("./exdata-data-household_power_consumption.zip","household_power_consumption.txt"), sep=";", header=TRUE, na.strings="?",colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric"))

## get only the data for the correct dates
CorrectDates<-HouseholdPowerConsumption$Date=="2/2/2007" | HouseholdPowerConsumption$Date=="1/2/2007"
PowerData<-HouseholdPowerConsumption[CorrectDates,]

## combine the date and text fields into a single date/time
PowerData$DateTimeText<-paste(PowerData$Date,PowerData$Time,sep="-")
PowerData$DateTimeValue<-strptime(PowerData$DateTimeText, format="%d/%m/%Y-%H:%M:%S")




## create the png file of the right name and size
png("./plot3.png", width=480, height=480)

## plot the line chart
plot(range(PowerData$DateTimeValue),range(PowerData$Sub_metering_1), type="n", ylab="Energy sub metering", xlab="",yaxt="n")
## create the custom y axis
axis(2,at=seq(0,40, by=10))
## put on the three lines
lines(PowerData$DateTimeValue,PowerData$Sub_metering_1, col="black", type="l")
lines(PowerData$DateTimeValue,PowerData$Sub_metering_2, col="red", type="l")
lines(PowerData$DateTimeValue,PowerData$Sub_metering_3, col="blue", type="l")
## add the legend
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1))
dev.off()




