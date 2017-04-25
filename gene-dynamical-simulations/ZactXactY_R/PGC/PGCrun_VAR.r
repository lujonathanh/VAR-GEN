#library(foreach)
library(doParallel)
library(R.matlab)
library(vars)

registerDoParallel(cores=24)

data<-readMat("expression_ZXYA_200000_Z->X->Y.mat")
expression<-data$expression
n <- dim(expression)[1]
T <- dim(expression)[2]

for (p in 1:9)
{
    source("PGC_VAR.r")
    B <- PairwiseGrangerRegress_VAR(expression, p);
    
    filename <- paste("PGC_run_VARS", p, ".mat", sep="_")
    writeMat(filename, B=B)
}