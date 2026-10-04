#!/bin/bash

./cleanup.sh && ./01_convert.sh && ./02_fix.sh && ./03_prepare.sh && ./04_ids_devices.sh && ./05_ids_probes.sh && ./06_cleanup.sh

echo "All done!"
