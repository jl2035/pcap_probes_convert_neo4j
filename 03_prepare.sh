#!/bin/bash

echo "Step 3"

for file in csvs/*; do
    echo "Processing: $file"
    base_name=$(basename ${file})
    cols="$(head -n 1 $file)"

    cat $file | grep -v --text "Probe Response" | grep --text "0x0004" > exports/${base_name}.requests.temp.csv
    cat $file | grep --text "Probe Response"| grep --text "0x0005" > exports/${base_name}.responses.temp.csv

    cat exports/${base_name}.requests.temp.csv | cut -f 5,12 -d$'\t' > exports/${base_name}.clients.temp.csv
    cat exports/${base_name}.responses.temp.csv | cut -f 6,12 -d$'\t' >> exports/${base_name}.clients.temp.csv
    cat exports/${base_name}.clients.temp.csv | sort | uniq > exports/${base_name}.clients.missing_headers.csv

    cat exports/${base_name}.requests.temp.csv | cut -f 11,12 -d$'\t' > exports/${base_name}.stations.temp.csv
    cat exports/${base_name}.responses.temp.csv | cut -f 11,12 -d$'\t' >> exports/${base_name}.stations.temp.csv
    cat exports/${base_name}.stations.temp.csv | sort | uniq > exports/${base_name}.stations.missing_headers.csv

    echo -e "mac\tfile" > exports/${base_name}.clients.csv
    cat exports/${base_name}.clients.missing_headers.csv >> exports/${base_name}.clients.csv

    echo -e "ssid\tfile" > exports/${base_name}.stations.csv
    cat exports/${base_name}.stations.missing_headers.csv >> exports/${base_name}.stations.csv

    echo "$cols" > exports/${base_name}.requests.csv
    echo "$cols" > exports/${base_name}.responses.csv
    cat exports/${base_name}.requests.temp.csv >> exports/${base_name}.requests.csv
    cat exports/${base_name}.responses.temp.csv >> exports/${base_name}.responses.csv

    rm exports/${base_name}.clients.missing_headers.csv
    rm exports/${base_name}.stations.missing_headers.csv
    rm exports/${base_name}.requests.temp.csv
    rm exports/${base_name}.responses.temp.csv
    rm exports/${base_name}.clients.temp.csv
    rm exports/${base_name}.stations.temp.csv
done
