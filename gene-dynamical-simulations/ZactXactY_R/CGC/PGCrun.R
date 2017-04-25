#library(foreach)
library(doParallel)
library(R.matlab)

registerDoParallel(cores=24)

data<-readMat("expression_ZX_200000_Z->X->Y.mat")
expression<-data$expression
n <- dim(expression)[1]
T <- dim(expression)[2]

for (p in 2:5)
{
    m <- T-p

    source("PGC.R")
    B <- PairwiseGrangerRegress(expression, p);

    filename <- paste("PGC_p", p, ".mat", sep="_")
    writeMat(filename, B=B)
}