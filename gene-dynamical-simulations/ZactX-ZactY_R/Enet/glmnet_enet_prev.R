glmnet_enet<- function(X, Y, alpha, lambda, lim)
{
    n <- dim(Y)[2]
    B <- foreach(i=1:lim, .combine='cbind') %dopar%
    {
        # In a foreach loop automatic print is closed
        #print(i)
        # Y is a vector.
        # using matrix to change it
        ycol <- Y[,i]
    
        ret <- glmnet(X, ycol, family='gaussian', standardize=FALSE, alpha=alpha ,lambda=lambda)
        return(matrix(ret$beta))
    }
    return(B)
}
