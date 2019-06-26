#!/bin/bash
inputFile=$1

if [ ! -f "$inputFile" ]; then
    echo "$inputFile not found!"
    exit -1
fi

cat $inputFile | awk -f 1a.awk | awk -F, -f 1b1c1d.awk | awk -F, -f 2.awk
