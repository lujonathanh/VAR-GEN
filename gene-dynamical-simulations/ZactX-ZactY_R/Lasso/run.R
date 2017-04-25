#library(foreach)
library(doParallel)
library(R.matlab)
library(glmnet)

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

source("glmnet_lasso.R")
B <- glmnet_lasso(X, Y, 0.001)

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
save(B, file='workspace_B.RData')
