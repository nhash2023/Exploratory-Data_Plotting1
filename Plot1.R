library(lubridate)

#read the available data
data <- read.table("C:\\Users\\14084\\OneDrive\\Documents\\Python Scripts\\household_power_consumption.txt", header= TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
summary(data)

#set data to numeric to be able to create the graph
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
dataset <- data[which(data$Date %in% as.Date(c("2007-02-01", "2007-02-02"))),] 
dataset$Global_active_power <- as.numeric(dataset$Global_active_power)

#print the graph as a picture
png(filename="plot1.png", width=480, height = 480 )

#create a histogram
par(las=1)
hist(dataset$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", main = "Global Active Power", col = "red")

dev.off()
