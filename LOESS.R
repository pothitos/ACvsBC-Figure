#!/usr/bin/Rscript

datapoints = read.delim("ACvsBC.dat", header=F)
smooth = loess(datapoints$V2 ~ datapoints$V1)
write.table(data.frame(smooth$x, smooth$fitted), "LOESS.dat", sep="\t",
            quote=F, col.names=F, row.names=F)
