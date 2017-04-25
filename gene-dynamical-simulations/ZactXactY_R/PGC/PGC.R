PairwiseGrangerRegress <- function(expression, p)
{
    # expression: n x T matrix of gene expression time series
    # p is the model order to use
    # referenced by function "granger.test" of "MSBVAR" package. 
    # The format of Y is T*n matrix
    y <- t(expression)
    library(doParallel)
    n <- ncol(y) # number of genes
    if (n < 2) {
        stop(paste("error: bivariate granger causality test needs at least 2 variables"))
    }
    #results <- matrix(0, m * (m - 1), 2)
    #namelist <- vector(mode = "character", m * (m - 1))
    #varnames <- dimnames(y)[[2]]
    #k <- 0

# B_ij is the p-value of regressing i on j
# i and j are both genes
# Y matrix is just the tiem series
# X matrix (the lagged vectors)

    B <- foreach(i=1:n, .combine='rbind') %dopar%
    {
        ret=matrix(0,1,n)

        # it is testing whether j granger causes i. 
        for (j in 1:n)
        {
            # Compute anyway, see what value?
            if (i == j)
            {
                next
            }
            
            
            # output Y
            # i , j
            # i_t, j_t, i_(t-1), j_(t-1), .... i_(t-p), j_(t-p)
            # Column i and column j in matrix
            # embeds shifted diagonal matrix
            # cbind = t by 2 matrix
            # i, j
            # First row of embed:
            # i_t, j_t, i_(t-1), j_(t-1), .... i_(t-p), j_(t-p)
            # i_(t-1), j_(t-1), .... i_(t-p), j_(t-p), i(t-p-1), j_(t-p-1)
            # ....
            # i_p, j_p,.... i_1, j_1
            
            # I_t = (i_t, ..., i_(t-p)
            # J_t = (j_t, ..., j_(t-p)
            # j_t = A * I_t + B * J_(t-1) Comptue SSR.
            # X_1 includes the regressors for I_t, J_(t-1)
            
            # j_t = C * J_(t-1). Computer SSR
            # X2 includes the regressors only for J_(t-1)
            
            # F-test: if the two measures of variance are of the same varian
            
            
            Y <- embed(cbind(y[, i], y[, j]), p + 1)
            
            #
            X1 <- Y[, -(1:2)]
            
            # taking the odd entries
            X2 <- X1[, ((1:p) * 2) - 1]
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
    # Change back to row causes column variables. 
    return(t(B))
}

