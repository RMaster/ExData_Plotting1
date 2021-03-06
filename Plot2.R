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

##step 5 : Plot Global active power vs datetime graph  with legends and title
plot(PowerDataSub$Global_active_power~PowerDataSub$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

##step 6 : save graph to PNG File
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
