#!/bin/bash

echo "Step 2"

for file in temp/*; do
    base_name=$(basename ${file})
    ./fix_cols.py ${file} csvs/${base_name}.csv
    #rm $file
done
