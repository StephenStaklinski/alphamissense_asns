import sys
import pandas as pd
import numpy as np

input_tsv = sys.argv[1]
output_file = sys.argv[2]
# input_tsv = "results/P08243_aa_substitutions.tsv"
# output_file="results/average_pathogenicity_score_aa.tsv"

# Load the TSV file into a DataFrame
df = pd.read_csv(input_tsv, sep='\t', header=0, skiprows=3)
df['aa'] = df['protein_variant'].str.extract(r'(\d+)')
df['aa'] = df['aa'].astype(int)
df = df.sort_values(by='aa')
df['am_pathogenicity'] = df['am_pathogenicity'].astype(float)
aa_score_df = df[["aa", "am_pathogenicity"]]
grouped_df = aa_score_df.groupby('aa')
aa_num = len(grouped_df)
aa_array = np.array(range(1, aa_num + 1, 1))
aa_avg_score = grouped_df['am_pathogenicity'].agg(np.average)
aa_avg_score_dict = {A: B for A, B in zip(aa_array, aa_avg_score)}

# Open the file in write mode
with open(output_file, 'w') as f:
    # Loop through the dictionary items and write them to the file
    for key, value in aa_avg_score_dict.items():
        f.write(f'{key}\t{value}\n')
