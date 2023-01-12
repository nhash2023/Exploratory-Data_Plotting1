library(lubridate)

#read the available data
data <- read.table("C:\\Users\\14084\\OneDrive\\Documents\\Python Scripts\\household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F)

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$full_date <- paste0(data$Date, " " , data$Time)
data$full_date <- as_datetime(data$full_date)

dataset <- data[which(data$Date %in% as.Date(c("2007-02-01", "2007-02-02"))),] 

#subset the variables presented
energy_columns <- grepl("Sub_metering", colnames(dataset), fixed=F)
dataset[,energy_columns] <- lapply(dataset[,energy_columns], function(x) {as.numeric(x)})

power_columns <- grepl("Sub_metering", colnames(dataset), fixed=F)
dataset[,power_columns] <- lapply(dataset[,power_columns], function(x) {as.numeric(x)})
dataset$Voltage <- as.numeric(dataset$Voltage)

#upload the graph as a picture format
png(filename="plot4.png", width=480, height = 480 )
par(mfrow=c(2,2))

#1) Global Active power vs. Weekday-Time
with(dataset, plot(Global_active_power~full_date, type='l', 
                            xlab = "", ylab="Global Active Power (kilowatts)" ))

#2) Voltage vs. Weekday-Time
with(dataset, plot(Voltage~full_date, type='l', 
                            xlab = "datetime"))

#3) Energy submetering vs. Weekday-time
with(dataset, plot(Sub_metering_1~full_date, type='l',
                            col = "black",
                            xlab = "", ylab="Energy sub metering" ))

with(dataset, lines(Sub_metering_2~full_date,
                             col = "red",
                             xlab = "", ylab="Energy sub metering" ))


with(dataset, lines(Sub_metering_3~full_date,
                             col = "blue",
                             xlab = "", ylab="Energy sub metering" ))

legend("topright", legend=c(colnames(selected_dataset[,energy_columns])), 
       bty = "n",
       col= c("black", "red", "blue"), lwd = 1, cex=0.8)

#4) Global re-ctive power vs. Weekday-Time
with(dataset, plot(Global_reactive_power~full_date, type='l', 
                            xlab = "datetime"))


dev.off()

