#!/bin/bash

echo "Fixing IDs for probes..."

for file in exports/*.requests.csv; do
    echo "File: $file"
    base_name=$(basename ${file})
    ./fix_ids_probe_requests.py $file
done

for file in exports/*.responses.csv; do
    echo "File: $file"
    base_name=$(basename ${file})
    ./fix_ids_probe_responses.py $file
done

echo "Done!"
