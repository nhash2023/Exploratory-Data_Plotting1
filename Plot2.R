library(lubridate)

#read the available data
data <- read.table("C:\\Users\\14084\\OneDrive\\Documents\\Python Scripts\\household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F)

#set data varibles to'numeric' to be able to create a graph
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$full_date <- paste0(data$Date, " " , data$Time)
data$full_date <- as_datetime(data$full_date)

dataset <- data[which(data$Date %in% as.Date(c("2007-02-01", "2007-02-02"))),] 
dataset$Global_active_power <- as.numeric(dataset$Global_active_power)

#upload graph as a picture file
png(filename="plot2.png", width=480, height = 480 )

#create a plot
with(dataset, plot(Global_active_power~full_date, type='l', 
                            xlab = "", ylab="Global Active Power (kilowatts)" ))

dev.off()
