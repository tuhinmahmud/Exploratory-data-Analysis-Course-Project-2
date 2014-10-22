pm25.24510 <- pm25[which(pm25$fips == "24510"), ]
aggregate.24510 <- with(pm25.24510, 
                        aggregate(Emissions, by = list(year), sum))
colnames(aggregate.24510) <- c("year", "Emissions")


plot(aggregate.24510, type = "o",
      ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year",
      main = "Total Emissions for Baltimore County",
      xlim = c(1999, 2008))
