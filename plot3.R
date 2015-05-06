library(tidyr)
library(dplyr)
library(sqldf)

file = 'household_power_consumption.txt'
df <- read.csv.sql(file,
                   sql = "select * from file 
                   where Date = '1/2/2007' or Date = '2/2/2007'",
                   header = TRUE,
                   sep = ";")
df <- unite(data = df,
            col = Dt,
            Date:Time,
            sep = " ",
            remove = TRUE)
df$Dt <- as.POSIXct(x = df$Dt,tz = "UTC",format = "%d/%m/%Y %H:%M:%S")

png(filename = "plot3.png",
    width = 480,
    height = 480)
plot(x = df$Dt,
     y = df$Sub_metering_1,type="l", 
     ylab ="Energy Sub Metering", 
     xlab="")
lines(x = df$Dt,
      y = df$Sub_metering_2,
      type="l",
      col="red")
lines(x = df$Dt,
      y = df$Sub_metering_3,
      type="l",
      col="blue")
legend(x = 'topright',
       y = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3")  , 
       lty=1, 
       col=c('black', 'red', 'blue'), 
       bty='o', 
       cex=.75)
dev.off()
