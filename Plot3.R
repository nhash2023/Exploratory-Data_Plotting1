library(lubridate)

#read the available data
data <- read.table("C:\\Users\\14084\\OneDrive\\Documents\\Python Scripts\\household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F)

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$full_date <- paste0(data$Date, " " , data$Time)
data$full_date <- as_datetime(data$full_date)

dataset <- data[which(data$Date %in% as.Date(c("2007-02-01", "2007-02-02"))),] 

energy_columns <- grepl("Sub_metering", colnames(dataset), fixed=F)
dataset[,energy_columns] <- lapply(dataset[,energy_columns], function(x) {as.numeric(x)})

#upload created graph as a picture format
png(filename="plot3.png", width=480, height = 480 )

#create the requested graph 
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
       col= c("black", "red", "blue"), lwd = 1, cex=0.75)

dev.off()
