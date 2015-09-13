
## load the data from the zipped data file

HouseholdPowerConsumption<-read.table(unz("./exdata-data-household_power_consumption.zip","household_power_consumption.txt"), sep=";", header=TRUE, na.strings="?",colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric"))

## get only the data for the correct dates
CorrectDates<-HouseholdPowerConsumption$Date=="2/2/2007" | HouseholdPowerConsumption$Date=="1/2/2007"
PowerData<-HouseholdPowerConsumption[CorrectDates,]

## combine the date and text fields into a single date/time
PowerData$DateTimeText<-paste(PowerData$Date,PowerData$Time,sep="-")
PowerData$DateTimeValue<-strptime(PowerData$DateTimeText, format="%d/%m/%Y-%H:%M:%S")



## create the png file of the right name and size
png("./plot1.png", width=480, height=480)

## plot the histogram with the correct annotations
hist(PowerData$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", xlim=c(0,6), xaxt="n")
## create the custom x axis
axis(1,at=seq(0,6, by=2))
dev.off()

