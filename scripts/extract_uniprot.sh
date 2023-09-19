#!/bin/bash

uniprot=$1
# ASNS uniprot is P08243 for reference

output_file="data/${uniprot}_aa_substitutions.tsv"
aa_subs="AlphaMissense_raw_data/AlphaMissense_aa_substitutions.tsv"
head -n 4 $aa_subs > $output_file
grep "$uniprot" $aa_subs >> $output_file