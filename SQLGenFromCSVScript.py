import csv
import os
import argparse

def csv_to_sql_insert(csv_file, table_name, output_dir="output", batch_size=1000):
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
    
    # Initialize variables
    file_counter = 1
    row_counter = 0
    insert_statements = []
    
    # Open the CSV file
    with open(csv_file, 'r') as f:
        reader = csv.reader(f)
        
        # Retrieve headers (first row)
        headers = next(reader)
        
        for row in reader:
            # Construct each INSERT statement, skipping NULL values
            columns = []
            values = []
            for i, value in enumerate(row):
                if value:
                    columns.append(headers[i])
                    values.append(value.replace("'", "''"))  # Escape single quotes

            if columns:
                # Form the INSERT statement
                insert_stmt = "INSERT INTO {} ({}) VALUES ({});".format(
                    table_name,
                    ", ".join(columns),
                    ", ".join(["'{}'".format(val) for val in values])
                )
                insert_statements.append(insert_stmt)
                row_counter += 1

                # Write to a new .sql file every batch_size rows
                if row_counter % batch_size == 0:
                    output_file = os.path.join(output_dir, "insert_statements_{}.sql".format(file_counter))
                    with open(output_file, 'w') as out_f:
                        out_f.write("\n".join(insert_statements))
                    # Reset for the next file
                    insert_statements = []
                    file_counter += 1

        # Write any remaining insert statements to a new file
        if insert_statements:
            output_file = os.path.join(output_dir, "insert_statements_{}.sql".format(file_counter))
            with open(output_file, 'w') as out_f:
                out_f.write("\n".join(insert_statements))

# Main execution with CLI argument parsing
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Convert CSV file to SQL INSERT statements.")
    parser.add_argument("csv_file", help="Path to the input CSV file")
    parser.add_argument("table_name", help="Name of the SQL table for the INSERT statements")
    parser.add_argument("--output_dir", default="output", help="Directory to save the output SQL files")
    parser.add_argument("--batch_size", type=int, default=1000, help="Number of rows per SQL file")

    args = parser.parse_args()

    csv_to_sql_insert(args.csv_file, args.table_name, args.output_dir, args.batch_size)

