NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
BC <- subset(NEI, fips == "24510")
LA <- subset(NEI, fips == "06037")
library(dplyr)
sccCode <- SCC[grepl("[Mo]tor",SCC[[3]]),1]
BC <- filter(BC, SCC %in% sccCode)
LA <- filter(LA, SCC %in% sccCode)
BC <- mutate(BC, county = "Baltimore City")
LA <- mutate(LA, county = "Los Angeles County")
both <- rbind(BC, LA)
grouped <- group_by(both, year, county)
sumDf <- summarize(grouped, sum(Emissions))
names(sumDf)[3] <- "total"
library(ggplot2)
png(filename = "./plot6.png")
ggplot(sumDf, aes(year, total)) + 
        geom_line(aes(color = county), lwd = 2) + 
        geom_point(aes(color = county), pch = 19, size = 4) + 
        scale_x_discrete(breaks = c(1999, 2002, 2005, 2008)) + 
        coord_cartesian(xlim=c(1998, 2009)) + ylab("Total Emission From PM 2.5 ")
dev.off()