NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
sccCode <- SCC[grepl("[Cc]oal",SCC[[4]]),1]
coal <- filter(NEI, SCC %in% sccCode)
sumByYear <- with(coal, tapply(Emissions, year, sum))
library(ggplot2)
png(filename = "./plot4.png")
ggplot(data.frame(year = names(sumByYear), total = sumByYear), aes(year, total))+ 
        geom_line(aes(group = 1), lwd = 2) + 
        geom_point(pch = 8, col = "red", size = 4) + 
        ylab("Total Emission From PM 2.5 From Coal Combustion Related Sources")
dev.off()