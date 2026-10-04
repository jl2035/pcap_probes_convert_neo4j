#!/bin/bash

echo "Step 1"

cnt=0

for file in pcaps/*; do
    let cnt++;
    base_name=$(basename ${file})
    tshark -r $file \
        -T fields \
        -E header=y \
        -E separator=$'\t' \
        -E quote=d \
        -E occurrence=f \
        -e frame.number \
        -e frame.time_relative \
        -e frame.len \
        -e wlan.fc.type_subtype \
        -e wlan.sa \
        -e wlan.da \
        -e wlan.bssid \
        -e wlan.ssid \
        -e _ws.col.Info \
        > temp/${base_name}.txt
    echo "Processing ${base_name}"
done

echo "$cnt files written to temp/"
