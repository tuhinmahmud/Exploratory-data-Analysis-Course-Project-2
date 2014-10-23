library(dplyr)
#load summarySSC_PM25.rds and Source_Classification_Code.rds
source("load.R")
#use dplyr to get the summary of aggregate data of Emission field
adata<-
    pm25 %>%
    group_by(year) %>%
    summarize(total.emission=sum(Emissions))

#plot the grap of year vs total emission
png("plot1.png", width=4, height=4, units="in", res=300)
plot(adata, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Total Emissions in the United States")
#plot the regression line showing the decrease in the total emission over years
lmline <- lm(total.emission~year,data=adata)
abline(lmline,col="red")
dev.off()
