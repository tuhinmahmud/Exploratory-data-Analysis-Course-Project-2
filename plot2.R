#Q2: Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (fips == "24510") from 1999 to 2008? 

library(dplyr)
#load summarySSC_PM25.rds and Source_Classification_Code.rds
source("load.R")

#get the subset of data where fips == 24510
pm25subset <- pm25[which(pm25$fips == "24510"), ]

#use dplyr to get the summary of aggregate data of Emission field
adata<-
    pm25subset %>%
    group_by(year) %>%
    summarize(Emissions=sum(Emissions))

#plot the data 
png("plot2.png", width=4, height=4, units="in", res=300)
plot(adata, type = "o",
      ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year",
      main = "Total Emissions for Baltimore County",
      xlim = c(1999, 2008))
#plot the regression line showing the decrease in the total emission over years
lmline <- lm(Emissions~year,data=adata)
abline(lmline,col="red")
dev.off()
