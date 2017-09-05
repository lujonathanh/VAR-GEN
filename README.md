# VAR-GEN
Causal Network Inference and Analysis from Time Series

VAR-GEN is a software package that infers and analyzes causal networks from time series data.
It was developed by Jonathan Lu, Bianca Dumitrascu, and Professor Barbara Engelhardt in the [Engelhardt Group](beehive.cs.princeton.edu) at the Department of Computer Science at Princeton University
over 2016-2017.


# Requirements

    numpy, scipy, pandas, matplotlib, Stochpy (only for the simulation study)

It has been tested in Python 2.7 on MacOSX v.10.11.6.


# Method 

VAR-GEN applies regularized vector autoregression along with a permutation-based 
null and False Discovery control to infer causal networks. It was designed
for a high-dimensional gene-expression time series dataset, but is general enough to accomodate
any time series dataset.

# Acknowledgments
"preprocessing/get_DEG.R" and "preprocessing/compute_sv.R" were written by [Ian C. McDowell](http://people.duke.edu/~icm10/Blank.html)

The code under "gene-dynamical-simulations/ZactX-ZactY_R/" and "gene-dynamical-simulations/ZactXZactY_R/" were largely based on the [granger causality package](https://bitbucket.org/dtyu/granger-causality/wiki/Home) from Dantong Yu.

# Citation
(citation)

# Todo
* change path hard-coding
* example run