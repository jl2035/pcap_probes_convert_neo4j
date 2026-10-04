#!/bin/bash

echo "Step 4"

echo "Clients"
for file in exports/*.clients.csv; do
    echo "File: ${file}"
    base_name=$(basename ${file})
    ./fix_ids_devices.py $file
done

echo "Stations"
for file in exports/*.stations.csv; do
    echo "File: ${file}"
    base_name=$(basename ${file})
    ./fix_ids_devices.py $file
done

echo "Done!"
