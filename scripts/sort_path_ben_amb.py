import sys
import pandas as pd
import numpy as np

# input_tsv = sys.argv[1]
input_tsv = "data/asns_aa_substitutions.tsv"

# Load the TSV file into a DataFrame
df = pd.read_csv('your_input.tsv', sep='\t')

# Extract the group label (e.g., M1, C2) from the protein_variant column
df['group_label'] = df['protein_variant'].str.extract(r'([A-Z][0-9][A-Z])')

# Separate entries into pathogenic, benign, and ambiguous DataFrames
pathogenic_df = df[df['am_class'] == 'pathogenic']
benign_df = df[df['am_class'] == 'benign']
ambiguous_df = df[(df['am_class'] != 'pathogenic') & (df['am_class'] != 'benign')]

# Function to check if all entries in a group are pathogenic or benign
def is_all_pathogenic_or_benign(group_label):
    return (group_label in pathogenic_df['group_label'].values) and (group_label in benign_df['group_label'].values)

# Filter groups based on criteria and create final pathogenic and benign DataFrames
final_pathogenic_df = pd.DataFrame(columns=df.columns)
final_benign_df = pd.DataFrame(columns=df.columns)

for group_label in np.unique(df['group_label'].values):
    if is_all_pathogenic_or_benign(group_label):
        final_pathogenic_df = pd.concat([final_pathogenic_df, pathogenic_df[pathogenic_df['group_label'] == group_label]])
        final_benign_df = pd.concat([final_benign_df, benign_df[benign_df['group_label'] == group_label]])
    else:
        ambiguous_df = pd.concat([ambiguous_df, df[df['group_label'] == group_label]])

# Remove the intermediate DataFrames
df.drop(columns='group_label', inplace=True)
final_pathogenic_df.drop(columns='group_label', inplace=True)
final_benign_df.drop(columns='group_label', inplace=True)

# Save the final DataFrames to TSV files
final_pathogenic_df.to_csv('pathogenic.tsv', sep='\t', index=False)
final_benign_df.to_csv('benign.tsv', sep='\t', index=False)
ambiguous_df.to_csv('ambiguous.tsv', sep='\t', index=False)
