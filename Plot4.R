## step 1: Get All data from household_power_consumption.txt
powerData<-read.csv("./data/household_power_consumption.txt",  header=T,sep=";",na.strings="?")

## step2: convert Date variable in Date class with format dd/mm/yyyy 
powerData$Date<-as.Date(powerData$Date,format="%d/%m/%Y")

## Step 3 : Take subset of date from date 01-02-2007 to 02-02-2007 and remove original dataset to save memory
PowerDataSub <- subset(powerData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(powerData)

## step 4 : convert the Date and Time variables to Date/Time classes using the 'as.Date()' and paste functions.
DateTime <-paste(as.Date(PowerDataSub$Date), PowerDataSub$Time)
PowerDataSub$Datetime <- as.POSIXct(DateTime)

##step 5 : Plot 4 graphs in 2 rows and 2 columns graph  with legends and title

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(PowerDataSub, {
  plot(Global_active_power~Datetime, type="l",ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", ylab="Global Rective Power (kilowatts)",xlab="")
})

##step 6 : save graph to PNG File
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
