#Q6: Compare emissions from motor vehicle sources in Baltimore City 
#      with emissions from motor vehicle sources in Los Angeles County, 
#      California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

library(dplyr)
library(ggplot2)
pm25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#get subset with Short name matchin "motor"
SCC.motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.motor, ]
SCC.identifiers <- as.character(SCC.motor$SCC)
pm25$SCC <- as.character(pm25$SCC)
pm25.motor <- pm25[pm25$SCC %in% SCC.identifiers, ]

#get the total Emission  data for Baltimore City
pm25.motor.Baltimore <- pm25.motor[which(pm25.motor$fips == "24510"), ]

adata.Baltimore<-
    pm25.motor.Baltimore %>%
    group_by(year) %>%
    summarize(Emissions=sum(Emissions)) %>%
    mutate(County = "Baltimore")

#get the total Emission  data for Los Angles City
pm25.motor.LosAngles <- pm25.motor[which(pm25.motor$fips == "06037"), ]
adata.LosAngles <- 
    pm25.motor.LosAngles %>%
    group_by(year) %>%
    summarize(Emissions=sum(Emissions)) %>%
    mutate(County = "Los Angles")
    

#combine Baltimore and Los Angles data by rows
adata.Combined <- rbind(adata.LosAngles, adata.Baltimore )
adata.Combined$County <- as.factor(adata.Combined$County)


png("plot6.png")
p<-qplot(year, Emissions,
         data = adata.Combined,
         group = County,
         color = County,
         geom = c("point", "line"),
         ylab = expression("Total Emissions, PM"[2.5]),
         xlab = "Year",
         main = "Comparison of Total Emissions by County"
)
print(p)
dev.off()