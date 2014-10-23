#Q3.Of the four types of sources indicated by the type (point, nonpoint, onroad,
#   nonroad) variable,
#     i) which of these four sources have seen decreases in emissions from 1999-2008 
#        for Baltimore City? 
#     ii) Which have seen increases in emissions from 1999-2008? 
library(dplyr)
library(ggplot2)
#load summarySSC_PM25.rds and Source_Classification_Code.rds
source("load.R")

#subset the data for baltimore city
pm25baltimore <- pm25[which(pm25$fips == "24510"), ]

#use dplyr to get the summary of aggregate data of Emission field by
#Type and year
adataType<-
    pm25baltimore %>%
    group_by(type,year) %>%
    summarize(Emissions=sum(Emissions)) 

png("plot3.png")
q<-qplot(year, Emissions, data = adataType, group = type,
      color = type, geom = c("point", "line"),
      ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant")

print(q)
dev.off()
