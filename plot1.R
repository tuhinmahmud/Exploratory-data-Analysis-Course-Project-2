library(dplyr)
source("load.R")
adata<-
    pm25 %>%
    group_by(year) %>%
    summarize(Esum=sum(Emissions))

png("plot1.png", width=4, height=4, units="in", res=300)
plot(adata, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Total Emissions in the United States")
lmline <- lm(Esum~year,data=adata)
abline(lmline,col="red")
dev.off()
