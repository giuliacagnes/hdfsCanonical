#!/bin/bash
inputFile=$1

if [ ! -f "$inputFile" ]; then
    echo "$inputFile not found!"
    exit -1
fi

cat $inputFile | awk -f 1a1b1c1d2_total.awk
