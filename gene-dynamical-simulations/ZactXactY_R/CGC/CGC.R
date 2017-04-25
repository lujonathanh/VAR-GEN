ConditionalGrangerRegress <- function(expression, p)
{
    # referenced by function "granger.test" of "MSBVAR" package. 
    # The format of y is T*n matrix
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
            # column bind
            # Y <- embed(cbind(y[, i], y[, j]), p + 1)
            
            Y <- embed(y, p+1)


            # Remove all the contemp regressors
            X1 <- Y[, -(1:p)]
            #



            X2 <- X1[, -((0:(p-1)) * n + j)]
            
            
            
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
            ftest <- ((ssqR - ssqU)/p)/(ssqU/(nrow(Y) - n * p -
                1))
                
            ret[j] <- 1 - pf(ftest, p, nrow(Y) - n * p - 1)
            
            
        }
        return(ret)
    }
    
    print(B)
    print("B")
    # Change back to row causes column variables.
    return(t(B))
}

