library('sqldf')
pwrfile <- 'household_power_consumption.txt'
if (!file.exists(pwrfile)) {
  #download zip file
  download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip','household_power_consumption.zip')
  # unzip file into household_power_consumption.txt
  unzip('household_power_consumption.zip')
}
#open file connection
pf <- file(pwrfile)
#use sqldf() to read in the dates from the file connection 
#using SQL queries and create subsetted dataframe df
data <- sqldf("select * from pf where Date == '1/2/2007' or Date == '2/2/2007'  ",
              file.format = list(header = TRUE, sep = ";" ))
#close connection
close(pf)

#combind and convert date and time fields
data[['dateTime']] <- strptime(paste(data[['Date']],data[['Time']], sep=" "), "%d/%m/%Y %H:%M:%S")
#plot data
png("plot3.png")
with(data, plot(dateTime,Sub_metering_1, type = "l", xlab = "", ylab = 'Energy sub metering'))
with(data, lines(dateTime,Sub_metering_2,col = "red"))
with(data, lines(dateTime,Sub_metering_3,col = "blue"))
legend("topright", lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()