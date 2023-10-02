## Snakemake pipeline for visualizing AlphaMissense pathogenicity score by UniProtID. Analysis of Asparagine Synthetase predictions.

The goals of this repo are to:
1. Provide a Snakemake pipeline to visualize the AlphaMissense pathogenicity score data for any UniProt ID.
2. Perform a comparative analysis of predicted Asparagine Synthetase (ASNS) variant effects to known effects in the Asparagine Synthetase Deficiency (ASNSD) literature.

### AlphaMissense

This repo uses the AlphaMissense variant effect predictions database from the authors of Jun Cheng et al., Accurate proteome-wide missense variant effect prediction with AlphaMissense. Science 0, eadg7492 DOI:10.1126/science.adg7492. [AlphaMissense link](https://www.science.org/doi/10.1126/science.adg7492)

### Snakemake pipeline for average pathogenicity score analysis of any UniProt ID

I have provided a Snakemake pipeline to subset AlphaMissense data for any UniProt ID as follows:

Input:
1. UniProt ID specified in `workflow/config/config.yaml` with uppercase letters.

Output:
1. A plot of average pathogenicity scores per amino acid
2. A pdb file for the corresponding AlphaFold structure with beta factors colored by AlphaMissense avg pathogenicity scores as beta factors
3. A heatmap of all variant AlphaMissense pathogenicity scores for all positions. 

Users must first install [Snakemake](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html), then run from within the `workflow/` directory of this repo:
```
snakemake --use-conda --cores 1
```

### ASNS Analysis

To use any of the provided scripts outside of the Snakemake workflow, please install the conda env:
```
conda env create -f workflow/env/asns_variants.yml
```

The database was filtered for variants relevant to Asparagine Synthetase (ASNS, UniProt_id P08243) using `workflow/scripts/extract_uniprot.sh`. The ASNS protein structure (PDB 6GQ3) was colored for the average AlphaMissense pathogenicity score predictions from 0 to 1 in pymol using the script `workflow/scripts/color_structure_pymol.py`, which requires prior use of `workflow/scripts/average_pathogenicity_score_aa.py`.

![Alt text](/results/color_asns_structure/pathogenic_colored_asns_legend.png?raw=true "ASNS protein structure with amino acids colored by the average AlphaMissense pathogenicity score")

![Alt text](/results/P08243_plot_aminoacid_heatmap.png?raw=true "Heatmap of pathogenicity scores for all ASNS variants")

AlphaMissense predictions were highlighted for known critical residues in ASNS.

![Alt text](/results/plot_aminoacid_pathogenicity_score_highlight_structure.png?raw=true "Average AlphaMissense pathogenicity score by amino acid position and colored for known critical residues")

 AlphaMissense predictions were benchmarked to a list of known Asparagine Synthetase Deficiency (ASNSD) associated variants which were curated from a comprehensive literature search.

![Alt text](/results/plot_aminoacid_pathogenicity_score_with_asnsd.png?raw=true "Average AlphaMissense pathogenicity score by amino acid position and colored for the prediction at those amino acids with a reported ASNSD variant in the literature")

### Questions

If any issues arise, then please post them here or contact me at staklins@cshl.edu. I can assist others that are characterizing ASNS variants.

### Copyright and license

The raw data is provided by AlphaMissense under Copyright 2023 DeepMind Technologies Limited.
This repo is licensed under [CC BY-NC-SA 4.0 license](https://creativecommons.org/licenses/by-nc-sa/4.0/)
