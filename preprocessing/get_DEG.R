#!/data/reddylab/software/anaconda/bin/Rscript
library(edgeR)

args <-commandArgs(TRUE)

mat <- args[1]
sv <- args[2]
y_mat_and_dispersion_out <- args[3]

# mat <- '/data/reddylab/projects/GGR/data/dnase_seq/quantified_read_counts/iter0_union/raw_read_counts_in_peak_union_selected_reps.txt'
# sv <- '/data/reddylab/projects/GGR/data/dnase_seq/quantified_read_counts/iter0_union/raw_read_counts_in_peak_union_selected_reps.surrogate_variables.txt'
# y_mat_and_dispersion_out <- '/data/reddylab/projects/GGR/results/dnase_seq/differential_accessibility/iter0/edgeR/raw_read_counts_in_peak_union_selected_reps.surrogate_variables.ymat_and_dispersion.rds'

mat <- read.table(mat, header = T, row.names=1, sep='\t')
sv <- as.matrix(read.table(sv, header = F, sep='\t'))
timepoint <- factor(sapply(strsplit(as.character(colnames(mat)), "_"), function(x) x[[1]]))
model_design <- model.matrix(~timepoint+sv)

print(paste('Observations, =', min(dim(model_design))))
print(paste('Parameters to estimate, =',qr(model_design)$rank))

####
y <- DGEList(counts = mat, group = timepoint)

y <- calcNormFactors(y, design=model_design)
y <- estimateGLMCommonDisp(y, design=model_design)
y <- estimateGLMTrendedDisp(y, design=model_design) 
y <- estimateGLMTagwiseDisp(y, design=model_design)

saveRDS(y, y_mat_and_dispersion_out)