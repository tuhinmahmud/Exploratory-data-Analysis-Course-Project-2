library(plyr)
library(ggplot2)

aggregate.data <- with(pm25, aggregate(Emissions, by = list(year), sum))


plot(aggregate.data, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Total Emissions in the United States")
    polygon(aggregate.data, col = "green", border = "blue")
