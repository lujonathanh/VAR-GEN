#!/usr/bin/env bash

source ./package_params_cpipeline.sh

FDRS=("g" "l")
FDRALIASES=("none" "effect")
FDRTHRESHOLD=0.05

for i in `seq 0 1`;
do
    FDR=${FDRS[i]}
    FDRALIAS=${FDRALIASES[i]}
    echo $FDR
    echo $FDRALIAS

    OUTDIR=run_$FDR-fdr

    mkdir $OUTDIR

    echo "Moving main files to folder: $OUTDIR"

    echo "### DATA ###"

    mkdir $OUTDIR/data
    cp $DATANAME $OUTDIR/data
    cp $RANDDATANAME $OUTDIR/data
    cp $GENENAME $OUTDIR/data

    touch $OUTDIR/data/files.csv
    echo DATANAME,$DATANAME >> $OUTDIR/data/files.csv
    echo RANDDATANAME,$RANDDATANAME >> $OUTDIR/data/files.csv

    if [ "$LOADREPS" != "0" ];
    then
        while read file; do
            cp $file $OUTDIR/data
        done <$DATANAME

        while read file; do
            cp $file $OUTDIR/data
        done <$RANDDATANAME
    fi

    echo "### HYPER ###"
    mkdir $OUTDIR/hyper
    cp -r hyper/*_* $OUTDIR/hyper

    echo "### FIT ###"
    mkdir $OUTDIR/fit
    cp -r fit/$OUTPUTNAME"_fit"* $OUTDIR/fit
    cp fit_all_summary_normal.txt $OUTDIR/fit
    cp fit_all_summary_fdr-$FDRALIAS.txt $OUTDIR/fit/fit_all_summary_$FDR-fdr.txt

    echo "### NETWORKS ###"
    mkdir $OUTDIR/networks
    ls fdr-$FDRTHRESHOLD-$FDRALIAS > tmp
    while read file; do
        cp -r fdr-$FDRTHRESHOLD-$FDRALIAS/$file $OUTDIR/networks/$(python della_convert_filename.py -f $file)
    done < tmp

    rm tmp

    echo "### PLOTS ###"
    cp -r plots $OUTDIR

    echo "### PARAMS ###"
    cp package_params_cpipeline.sh $OUTDIR
    cp params.csv $OUTDIR


done


