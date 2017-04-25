#library(foreach)
library(doParallel)
library(R.matlab)

registerDoParallel(cores=24)

data<-readMat("filter_norm_expression.mat")
expression<-data$expression
n <- dim(expression)[1]
T <- dim(expression)[2]

p <- 3
m <- T-p

X <- matrix(0,m,n*p)
for (j in 1:m)
{
    for (k in 1:p)
    {
        X[j,(n*(k-1)+1):(n*k)] <- t(expression[,j+p-k])
    }
}
Y <- t(expression[,(p+1):T])
save.image("workspace.RData")

source("ridgeSVD.R")
B <- ridge(X, Y, 1)

#save.image("resultspace.RData")
save(B, file='workspace_B.RData')
