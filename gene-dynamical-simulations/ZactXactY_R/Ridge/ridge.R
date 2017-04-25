ridge <- function(X, Y, lambda)
{
    #Xsvd <- svd(X)
    n <- dim(X)[2]
    B <- solve(t(X)%*%X + lambda*diag(n))%*%t(X)%*%Y
    return(B)
}
