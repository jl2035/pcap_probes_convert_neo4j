#!/usr/bin/python
import csv
import sys

if len(sys.argv) != 3:
    print("Usage: ./fix_cols.py input_file output_file")
    sys.exit(1)

packet_types = {
    "0x0008": "Beacon frame",
    "0x0004": "Probe Request",
    "0x0005": "Probe Request",
}

output_file = open(sys.argv[2], 'w')
csv_writer = csv.writer(output_file, delimiter="\t", quotechar='"')

line_count = 0
cols = None

def hex_fallback(hex_value):
    for i in range(len(hex_value), 2, -1):
        try:
            real_ssid = bytes.fromhex(hex_value[:i]).decode()
            return real_ssid
        except:
            continue
    return "BADSSID"

def clean_ssid(ssid):
    return ssid.replace('"', '').replace('{', '').replace('}', '')

with open(sys.argv[1], newline="", encoding="utf-8") as input_file:
    print(f"Processing {sys.argv[1]}")
    for row in csv.reader(input_file, delimiter="\t", quotechar='"'):
        line_count += 1
        if line_count == 1:
            row.append("packet_type")
            row.append("ssid_str")
            row.append("file")
            csv_writer.writerow(row)
            output_file.flush()
            continue
        print(line_count, end='\r')
        if row[3] in packet_types:
            row.append(packet_types[row[3]])
        else:
            row.append("Unknown")
        ssid_hex = row[7]
        if ssid_hex == "<MISSING>":
            continue
        try:
            real_ssid = bytes.fromhex(ssid_hex).decode()
        except:
            try:
                real_ssid = hex_fallback(ssid_hex) + "_someshit"
            except:
                print(f"Cannot convert this: {row[7]}")
                pass
        
        row.append(clean_ssid(real_ssid))
        desc = row[8].replace("\\", "").replace('"', '')
        row[8] = desc
        row.append(sys.argv[1].split('/')[-1].replace(".txt", ""))
        csv_writer.writerow(row)
        output_file.flush()

output_file.close()
