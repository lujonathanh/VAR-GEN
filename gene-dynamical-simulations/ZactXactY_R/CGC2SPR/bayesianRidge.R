bayesianRidge <- function(X, Y, W, lambdaone, lambdatwo)
{
    # CGC2SPR 
    # The first step is a normal ridge regression
    # The second step is using acquired B to obtain the sign of W
    # The last step is to use SVD to calculate real B matrix

    B <- ridge(X,Y,lambdaone)
    Wsigned <- W * sign(B)

    Xs <- svd(X)
    temp <- t(X)%*% Y + lambdaone*lambdatwo*Wsigned
    temp <- t(Xs$v)%*% temp

    div <- Xs$d^2 + rep(lambdaone, length(Xs$d))
    temp <- temp/div
    coef <- Xs$v %*% temp

    #rhs <- t(Xs$u) %*% Y
    #d <- Xs$d
    
    #div <- d^2 + rep(lambda, length(d))
    #a <- drop(d * rhs)/div
    #dim(a) <- c(dx, k)
    #coef <- Xs$v %*% a

    return(coef)
}
