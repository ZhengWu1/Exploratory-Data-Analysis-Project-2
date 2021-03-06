NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
sumByYear <- with(NEI, tapply(Emissions, year, sum))
png(filename = "./plot1.png")
plot(names(sumByYear), sumByYear, type = "l", lwd = 3, xlab = "Year", ylab = "Total Emission From PM 2.5 From All Sources", xaxt="n") + points(names(sumByYear), sumByYear, pch = 8, col = "red") + axis(1, at = c(1999, 2002, 2005, 2008))
dev.off()