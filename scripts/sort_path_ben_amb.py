import sys
import pandas as pd
import numpy as np

# input_tsv = sys.argv[1]
# output_diir = sys.argv[2]
input_tsv = "results/P08243_aa_substitutions.tsv"
output_dir="results/P08243_aa_substitutions_sorted/"

# Load the TSV file into a DataFrame
df = pd.read_csv(input_tsv, sep='\t', header=0, skiprows=3)
df['aa'] = df['protein_variant'].str.extract(r'(\d+)')
df['aa'] = df['aa'].astype(int)
df = df.sort_values(by='aa')
grouped_df = df.groupby('aa')
aa_num = len(grouped_df)
aa_array = np.array(range(1, aa_num + 1, 1))
am_class_uniq_array = np.array([','.join(group['am_class'].unique()) for _,group in grouped_df])

uniq_am_class_dict = {A: B for A, B in zip(aa_array, am_class_uniq_array)}

pathogenic_only = []
benign_only = []
other = []

min_one_pathogenic = []
none_pathogenic = []

for key, value in uniq_am_class_dict.items():
    
    labels = value.split(',')

    if 'pathogenic' in labels:
        min_one_pathogenic.append(str(key))
    else:
        none_pathogenic.append(str(key))

    if len(labels) == 1:
        if labels == 'pathogenic':
            pathogenic_only.append(str(key))
        elif labels == 'benign':
            benign_only.append(str(key))
        else:
            other.append(str(key))
    else:
        other.append(str(key))

# Write data to txt files
with open(f'{output_dir}pathogenic_only.txt', 'w') as file:
    file.write('\n'.join(pathogenic_only))

with open(f'{output_dir}benign_only.txt', 'w') as file:
    file.write('\n'.join(benign_only))

with open(f'{output_dir}minimum_one_pathogenic_sub.txt', 'w') as file:
    file.write('\n'.join(min_one_pathogenic))

with open(f'{output_dir}no_pathogenic_sub.txt', 'w') as file:
    file.write('\n'.join(none_pathogenic))

