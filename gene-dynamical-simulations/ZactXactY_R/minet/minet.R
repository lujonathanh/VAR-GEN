library(R.matlab)
library(minet)

data<-readMat("filter_norm_expression.mat")
expression<-data$expression

n <- dim(expression)[1]
T <- dim(expression)[2]
p <- 3

discdata <- discretize(t(expression), "equalwidth", 10)
mim <- build.mim(discdata, "mi.shrink")

# MIM output
sink("mim_output", append=FALSE)
for(i in 1:n)
{
    for(j in 1:n)
    {
        if (i!=j)
        {
            writeLines(sprintf("%d\t%d\t%f", i, j, mim[i,j]))
        }
    }
}
sink()

# MRNET algorithm
net <- mrnet(mim)
sink("mrnet_output", append=FALSE)
for(i in 1:n)
{
    for(j in 1:n)
    {
        if (i!=j)
        {
            writeLines(sprintf("%d\t%d\t%f", i, j, net[i,j]))
        }
    }
}
sink()

# CLR algorithm
net <- clr(mim)
sink("clr_output", append=FALSE)
for(i in 1:n)
{
    for(j in 1:n)
    {
        if (i!=j)
        {
            writeLines(sprintf("%d\t%d\t%f", i, j, net[i,j]))
        }
    }
}
sink()

# ARACNE
net <- aracne(mim)
sink("aracne_output", append=FALSE)
for(i in 1:n)
{
    for(j in 1:n)
    {
        if (i!=j)
        {
            writeLines(sprintf("%d\t%d\t%f", i, j, net[i,j]))
        }
    }
}
sink()
