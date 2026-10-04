#!/usr/bin/python
import csv
import sys
import uuid

if len(sys.argv) != 2:
    print("Usage: ./fix_ids_probe_requests.py filename")
    sys.exit(1)

def read_file(filename):
    output = []
    f = open(filename, 'r')
    while True:
        line = f.readline()
        if not line:
            break
        row = line.split("\t")
        output.append(row)
    return output

clients = read_file(sys.argv[1].replace("requests", "clients"))
stations = read_file(sys.argv[1].replace("requests", "stations"))

def find_id_by_client_mac(mac):
    cnt = 0
    for client in clients:
        if cnt == 0:
            cnt += 1
            continue
        if client[1] == mac:
            return client[0]
    raise Exception(f"Couldn't find client with mac {mac}")

def find_id_by_ssid(ssid):
    cnt = 0
    for station in stations:
        if cnt == 0:
            cnt += 1
            continue
        if str(station[1]) == ssid:
            return station[0]
    raise Exception(f"Couldn't find station with ssid {ssid}")

cnt = 0
headings = []
rows = []
with open(sys.argv[1], newline="", encoding="utf-8") as input_file:
    for row in csv.reader(input_file, delimiter="\t"):
        if cnt == 0:
            headings = row
            cnt += 1
            continue
        row.append(find_id_by_client_mac(row[4]))
        row.append(find_id_by_ssid(row[10]))
        rows.append(row)

headings.append("client_id")
headings.append("station_id")
headings.insert(0, 'id')

with open(sys.argv[1], 'w') as output_file:
    csv_writer = csv.writer(output_file, delimiter="\t", quotechar='"')
    csv_writer.writerow(headings)
    for row in rows:
        row.insert(0, str(uuid.uuid4()))
        csv_writer.writerow(row)
