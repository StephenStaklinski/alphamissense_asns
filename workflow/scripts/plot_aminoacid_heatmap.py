import sys
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

input_path = sys.argv[1]
output_path = sys.argv[2]

# Read the TSV file into a DataFrame
data = pd.read_csv(input_path, delimiter="\t", header=0, skiprows=3)
data.columns = ["Protein", "Mutation", "Score", "Status"]

# Extract relevant information for the heatmap
data["Position"] = data["Mutation"].apply(lambda x: int(x[1:-1]))  # Extract the number between the letters
data["Amino Acid"] = data["Mutation"].apply(lambda x: x[-1])  # Extract the last letter

# Pivot the DataFrame to create the heatmap data
heatmap_data = data.pivot(index="Amino Acid", columns="Position", values="Score")

# Create the heatmap using Seaborn
plt.figure(figsize=(12, 6))
heatmap = sns.heatmap(heatmap_data, cmap="coolwarm", annot=False, fmt=".2f", cbar_kws={'label': 'AM pathogenicity score'})
plt.xlabel("Position")
plt.ylabel("Alternate amino acid")
plt.tight_layout()
plt.savefig(output_path, format="png")
