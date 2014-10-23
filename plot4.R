#Q4: Across the United States, how have emissions from coal 
#      combustion-related sources changed from 1999-2008?
library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC.coal <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
SCC.coal <- SCC[SCC.coal, ]
SCC.identifiers <- as.character(SCC.coal$SCC)

NEI$SCC <- as.character(NEI$SCC)
NEI.coal <- NEI[NEI$SCC %in% SCC.identifiers, ]

adataCoal<-
    NEI.coal %>%
    group_by(year) %>%
    summarize(Emissions=sum(Emissions)) 

png("plot4.png")
plot(adataCoal, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Emissions and Total Coal Combustion for the United States", 
        xlim = c(1999, 2008))
#plot the regression line showing the decrease in the total emission over years
lmline <- lm(Emissions~year,data=adataCoal)
abline(lmline,col="red")
dev.off()
