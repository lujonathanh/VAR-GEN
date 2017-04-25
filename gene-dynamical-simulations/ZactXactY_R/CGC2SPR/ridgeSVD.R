ridge <- function(X, Y, lambda)
{
    # referenced on lm.ridge algorithm
    # This is using svd to solve the ridge problem
    # B <- (XT*X+lambda*I)-1*XT*Y
    # SVD of X in R is X(m*n) = U(m*m)D(m*m)V(m*n)
    # X = Xs$u %*% diag(Xs$d) %*% t(Xs$v)

    Xs <- svd(X)
    rhs <- t(Xs$u) %*% Y
    d <- Xs$d

    #lscoef <- Xs$v %*% (rhs/d)
    #lsfit <- X %*% lscoef
    #resid <- Y - lsfit
    
    k <- length(lambda)
    dx <- length(d)
    div <- d^2 + rep(lambda, rep(dx, k))
    a <- drop(d * rhs)/div
    #dim(a) <- c(dx, k)
    coef <- Xs$v %*% a

    return(coef)
}
