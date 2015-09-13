
## load the data from the zipped data file

HouseholdPowerConsumption<-read.table(unz("./exdata-data-household_power_consumption.zip","household_power_consumption.txt"), sep=";", header=TRUE, na.strings="?",colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric"))

## get only the data for the correct dates
CorrectDates<-HouseholdPowerConsumption$Date=="2/2/2007" | HouseholdPowerConsumption$Date=="1/2/2007"
PowerData<-HouseholdPowerConsumption[CorrectDates,]

## combine the date and text fields into a single date/time
PowerData$DateTimeText<-paste(PowerData$Date,PowerData$Time,sep="-")
PowerData$DateTimeValue<-strptime(PowerData$DateTimeText, format="%d/%m/%Y-%H:%M:%S")




## create the png file of the right name and size
png("./plot2.png", width=480, height=480)
## plot the line chart
plot(PowerData$DateTimeValue,PowerData$Global_active_power, ylab="Global Active Power (kilowatts)", xlab="", type="n")
## put the lines on rather than showing open circles for points
lines(PowerData$DateTimeValue,PowerData$Global_active_power, type="l")
dev.off()



