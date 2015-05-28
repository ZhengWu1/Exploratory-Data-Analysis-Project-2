NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
BC <- subset(NEI, fips == "24510")
library(dplyr)
sccCode <- SCC[grepl("[Mo]tor",SCC[[3]]),1]
BC <- filter(BC, SCC %in% sccCode)
groupedBC <- group_by(BC, year)
sumDf <- summarize(groupedBC, sum(Emissions))
names(sumDf)[2] <- "total"
library(ggplot2)
png(filename = "./plot5.png")
ggplot(sumDf, aes(year, total)) + 
        geom_line(lwd = 2) + 
        geom_point(pch = 19, size = 4, col = "red") + 
        scale_x_discrete(breaks = c(1999, 2002, 2005, 2008)) + 
        coord_cartesian(xlim=c(1998, 2009)) + ylab("Total Emission From PM 2.5 ")
dev.off()