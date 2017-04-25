#library(foreach)
library(doParallel)
library(R.matlab)
library(glmnet)

registerDoParallel(cores=24)

input_file <- "expression_ZXYA_200000_Z->X->Y.mat"
data<-readMat(input_file)
expression<-data$expression
n <- dim(expression)[1]
T <- dim(expression)[2]

p <- 5
m <- T-p

# X is m by n*p
# m is number of time series points
# n * p is number of regressors
# X has the same genes grouped together, seperated by time points
# Y is target,
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

source("glmnet_lasso.R")

lams <- c(0.001, 0.01, 0.1, 1, 10)

for (lam in lams) {
    B <- glmnet_lasso(X, Y, lam)

    filename <- paste(input_file, "lasso_B", lam, ".mat", sep="_")
    writeMat(filename, B=B)
}

# B is the value of the co-efficients
# B is #regressors by #outputs

## foreach loop is essentially a function
#B <- foreach(i=1:n, .combine='cbind') %dopar%
#{
#    # In a foreach loop automatic print is closed 
#    print(i)
#    # Y is a vector.
#    # using matrix to change it
#    ycol <- Y[,i]
#
#    ret <- glmnet(X, ycol, family='gaussian', standardize=FALSE, lambda=0.001, intercept=FALSE)
#    return(matrix(ret$beta))
#}

#save.image("resultspace.RData")
#save(B, file='workspace_B.RData')
