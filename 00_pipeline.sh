#!/bin/bash

./cleanup.sh && ./01_convert.sh && ./02_fix.sh && ./03_prepare.sh && ./04_ids_devices.sh && ./05_ids_probes.sh

rm -rf temp/*
rm -rf csvs/*

echo "All done!"
