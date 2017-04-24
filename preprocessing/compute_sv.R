#!/usr/bin/env Rscript 
library(sva)
args <-commandArgs(TRUE)
options(stringsAsFactors = FALSE)

mat = args[1]
out_svs = args[2]
out_mat = args[3]

mat <- read.table(mat, header = T, row.names=1, sep='\t')

## the following is unnecessary because all sites have non-zero counts in at least 10% of samples:
# filter out sites with 0 counts for over 10% of samples
mat = mat[apply(mat, 1, function(x) length(x[x != 0])/length(x) > 0.10),] 

# set up models
group <- factor(sapply(strsplit(as.character(colnames(mat)), "_"), function(x) x[[1]]))
mod = model.matrix(~as.factor(group))
mod0 = cbind(mod[,1])

## for time considerations, may select the top X most variable sites for surrogate variable analysis
# vfilter = 20000
# var = rowVars(mat)
# ind = which(rank(-var) < vfilter)
# mat = mat[ind, ]
    
res = svaseq(as.matrix(mat), mod, mod0)

log_mat = log(mat + 1)

cleanY = function(y, mod, svs) {
    X = cbind(mod, svs)
    Hat = solve(t(X) %*% X) %*% t(X)
    beta = (Hat %*% t(y))
    rm(Hat)
    gc()
    P = ncol(mod)
    return(y - t(as.matrix(X[,-c(1:P)]) %*% beta[-c(1:P),]))
}

# regress out surrogate variables
Y = cleanY(log_mat, mod, res$sv)

write.table(file=out_svs, res$sv, sep="\t", quote=F, row.names=F, col.names=F)
write.table(file=out_mat, Y, sep="\t", quote=F, row.names=T, col.names=NA)