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

png(filename = "plot2.png",
    width = 480,
    height = 480)
plot(x=df$Dt,
     y = df$Global_active_power,
     type="l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()
