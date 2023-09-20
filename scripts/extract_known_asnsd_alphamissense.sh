#!/bin/bash

# Check if both input files are provided as arguments
# if [ $# -ne 3 ]; then
#     echo "Usage: $0 key_file data_file output_file"
#     exit 1
# fi

# key_file="$1"
# data_file="$2"
# output_file="$3"
key_file="asnsd_variants_raw_data/asnsd_missense_variants.txt"
data_file="results/P08243_aa_substitutions.tsv"
output_file="results/extracted_alphamissense_known_asnsd_variants.tsv"

# Check if the key file exists
if [ ! -f "$key_file" ]; then
    echo "Key file '$key_file' does not exist."
    exit 1
fi

# Check if the data file exists
if [ ! -f "$data_file" ]; then
    echo "Data file '$data_file' does not exist."
    exit 1
fi

# Initialize the output file
> "$output_file"

# Loop through each key in the key file and grep matching lines from the data file
while IFS= read -r key; do
    grep "$key" "$data_file" >> "$output_file"
done < "$key_file"
