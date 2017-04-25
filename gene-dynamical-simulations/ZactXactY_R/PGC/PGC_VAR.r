PairwiseGrangerRegress_VAR <- function(expression, p)
{
    # expression: n x T matrix of gene expression time series
    # p is the model order to use
    # referenced by function "granger.test" of "MSBVAR" package. 
    # The format of Y is T*n matrix
    
    y <- t(expression)
    library(doParallel)
    library(vars)
    n <- ncol(y) # number of genes
    if (n < 2) {
        stop(paste("error: bivariate granger causality test needs at least 2 variables"))
    }
    
    
    B = matrix(rep(0, times= n*n), n, n)
    
    for (i in 1:n) {
        if (i < n) {

            for (j in (i+1):n) {
                # get B's ith and jth columns
                
                print(paste("i is", i))
                print(paste("j is", j))
                Y <- cbind(y[,i], y[,j])
                colnames(Y) <- c("i", "j")
                print("Y is ")
                print(Y)
                var.data <- VAR(Y, p=p, type="const")
                print("data done")
                cij <- causality(var.data, cause="i")
                print("Causality done")
                print(cij)
                print(cij$Granger$p.value)
                print(B[i,j])
                B[i,j] <- cij$Granger$p.value
                print("B done")
                cji <- causality(var.data, cause="j")
                
                B[j,i] <- cji$Granger$p.value
            }
        }
    }
    
    return(B)
}

