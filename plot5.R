library(ggplot2)
library(plyr)
pm25 <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

scc.motor <- grep("motor", scc$Short.Name, ignore.case = TRUE)
scc.motor <- scc[scc.motor, ]
scc.identifiers <- as.character(scc.motor$SCC)
pm25$SCC <- as.character(pm25$SCC)
pm25.motor <- pm25[pm25$SCC %in% scc.identifiers, ]

pm25.motor.24510 <- pm25.motor[which(pm25.motor$fips == "24510"), ]

aggregate.motor.24510 <- with(pm25.motor.24510, aggregate(Emissions, by = list(year), 
    sum))

plot(aggregate.motor.24510, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
        xlab = "Year", main = "Total Emissions from Motor Vehicle Sources")
