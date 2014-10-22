library(plyr)
#library(ggplot2)

aggregate.data <- with(pm25, aggregate(Emissions, by = list(year), sum))

png("plot1.png", width=4, height=4, units="in", res=300)
plot(aggregate.data, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Total Emissions in the United States")
dev.off()
