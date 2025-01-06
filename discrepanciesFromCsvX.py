import csv
import sys
import datetime


def process_csv(input_file, output_file):
    required_headers = ['From', 'NIC', 'SRN']
    ignore_columns = ['VLN', 'VLD', 'ORI', 'MKET', 'MKE', 'ATR', 'ADD', 'ADR', '[ADD]', 'STS', 'DTM', 'DLU', 'DTE']

    with open(input_file, 'r') as infile:
        reader = csv.DictReader(infile)
        rows = list(reader)
        all_headers = [header.upper() for header in reader.fieldnames]

    grouped_rows = {}
    for row in rows:
        nic = row['NIC']
        if not nic or nic.strip() == '':
            nic = '<NULL>'
        row['From'] = 'NCIC' if row['From'] == 'TMP' else 'SDSO'
        grouped_rows.setdefault(nic, []).append(row)

    discrepancies = []

    def preprocess(value, is_num=False):
        if value is None or str(value).isspace() or str(value).strip() == '':
            return '<NULL>'
        value = str(value).strip().upper().replace('O', '0')
        if is_num:
            return int(value)
        return value

    for nic, group in grouped_rows.items():
        if len(group) == 2:
            row1, row2 = group
            headers_to_write = required_headers[:]

            for header in all_headers:
                if header not in required_headers and header not in ignore_columns:
                    is_num = True if (header == 'OLN') else False
                    value1 = preprocess(row1.get(header, '<NULL>'), is_num)
                    value2 = preprocess(row2.get(header, '<NULL>'), is_num)
                    if value1 != value2:
                        if header not in headers_to_write:
                            headers_to_write.append(header)

            if len(headers_to_write) > len(required_headers):
                discrepancy_row1 = {h: preprocess(row1.get(h, '<NULL>')) for h in headers_to_write}
                discrepancy_row2 = {h: preprocess(row2.get(h, '<NULL>')) for h in headers_to_write}

                discrepancies.append((headers_to_write, discrepancy_row1))
                discrepancies.append((headers_to_write, discrepancy_row2))
                discrepancies.append(([], {}))

    total_entries = len(rows)
    discrepancy_count = len(discrepancies) // 3
    current_date = datetime.datetime.now().strftime('%Y-%m-%d')

    stats_row = [
        "TOTAL ENTRIES", "DISCREPANCIES", "DATE"
    ]
    stats_data = [
        total_entries, discrepancy_count, current_date
    ]

    with open(output_file, 'w') as outfile:
        writer = csv.writer(outfile)

        writer.writerow(stats_row)
        writer.writerow(stats_data)
        writer.writerow([])
        writer.writerow(["IDENTIFIERS", "", "", "DISCREPANCIES"])
        writer.writerow([])

        for headers, row in discrepancies:
            if headers and row:
                writer.writerow(headers)
                writer.writerow([row[h] for h in headers])
            elif not headers and not row:
                writer.writerow([])


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: python discrepanciesFromCsv.py <INPUT_FILE> <OUTPUT_FILE>")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]
    process_csv(input_file, output_file)
