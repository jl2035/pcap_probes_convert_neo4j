#!/usr/bin/python
import csv
import sys

if len(sys.argv) != 2:
    print("Usage: ./fix_ids_devices.py filename")
    sys.exit(1)

rows = []
number = 0

with open(sys.argv[1], newline="", encoding="utf-8") as input_file:
    for row in csv.reader(input_file, delimiter="\t", quotechar='"'):
        row.insert(0, "id" if number == 0 else number)
        rows.append(row)
        number += 1

with open(sys.argv[1], 'w') as output_file:
    csv_writer = csv.writer(output_file, delimiter="\t", quotechar='"')
    for row in rows:
        csv_writer.writerow(row)
