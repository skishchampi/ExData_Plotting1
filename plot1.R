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

png(filename = "plot1.png",
    width = 480,
    height = 480)
hist(x = df$Global_active_power,
     xlab = "Global Active Power(kilowatts)",
     col = "red",
     main = "Global Active Power",
     ylab = "Frequency")
dev.off()
