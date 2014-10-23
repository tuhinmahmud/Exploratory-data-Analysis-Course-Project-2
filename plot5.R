#Q5:How have emissions from motor vehicle sources changed from 
#       1999-2008 in Baltimore City?

library(ggplot2)
library(plyr)
pm25 <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

#get subset data for name matching "motor"
scc.motor <- grep("motor", scc$Short.Name, ignore.case = TRUE)
scc.motor <- scc[scc.motor, ]
scc.identifiers <- as.character(scc.motor$SCC)
pm25$SCC <- as.character(pm25$SCC)

#get subset data with valid identifier
pm25.motor <- pm25[pm25$SCC %in% scc.identifiers, ]

#get subset data for Baltimore City
pm25.motor.Baltimore <- pm25.motor[which(pm25.motor$fips == "24510"), ]

adata<-
    pm25.motor.Baltimore %>%
    group_by(year) %>%
    summarize(Emissions=sum(Emissions)) 

png("plot5.png")
plot(adata, type = "o", 
        ylab = expression("Total Emissions, PM"[2.5]), 
        xlab = "Year",
        main = "Total Emissions from Motor Vehicle Sources in Baltimore City")
dev.off()
