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

#create plot
png("plot1.png")
hist(as.numeric(as.character(data[['Global_active_power']])), main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)', col = 'red')
dev.off()