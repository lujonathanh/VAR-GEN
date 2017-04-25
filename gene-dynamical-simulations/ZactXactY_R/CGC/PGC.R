PairwiseGrangerRegress <- function(expression, p)
{
    # referenced by function "granger.test" of "MSBVAR" package. 
    # The format of Y is T*n matrix
    y <- t(expression)
    library(doParallel)
    n <- ncol(y)
    if (n < 2) {
        stop(paste("error: bivariate granger causality test needs at least 2 variables"))
    }
    #results <- matrix(0, m * (m - 1), 2)
    #namelist <- vector(mode = "character", m * (m - 1))
    #varnames <- dimnames(y)[[2]]
    #k <- 0

    B <- foreach(i=1:n, .combine='rbind') %dopar%
    {
        ret=matrix(0,1,n)

        # it is testing whether j granger causes i. 
        for (j in 1:n)
        {
            if (i == j)
            {
                next
            }
            Y <- embed(cbind(y[, i], y[, j]), p + 1)
            X1 <- Y[, -(1:2)]
            X2 <- X1[, ((1:p) * 2) - 1]
            
            print(head(Y))
            print("Y")
            
            print(head(X1))
            print("X1")
            
            print(head(X2))
            print("X2")


            restricted <- lm(Y[, 1] ~ X2)
            unrestricted <- lm(Y[, 1] ~ X1)
            ssqR <- sum(restricted$resid^2)
            ssqU <- sum(unrestricted$resid^2)
            ftest <- ((ssqR - ssqU)/p)/(ssqU/(nrow(Y) - 2 * p -
                1))
            ret[j] <- 1 - pf(ftest, p, nrow(Y) - 2 * p - 1)
            
            
          
        }
        return(ret)
    }
    
    print(B)
    # Change back to row causes column variables. 
    return(t(B))
}

