## Snakemake pipeline for average AlphaMissense pathogenicity score by UniProtID. Analysis of Asparagine Synthetase predictions.

The goals of this repo are to:
1. Provide a Snakemake pipeline to analyze the average AlphaMissense pathogenicity score for any UniProt ID.
2. Perform a comparative analysis of predicted Asparagine Synthetase (ASNS) variant effects to known effects in the Asparagine Synthetase Deficiency (ASNSD) literature.
3. Simplify the accessibility of data from AlphaMissense predictions for those seeing patients with a potential diagnosis of ASNSD.

### AlphaMissense

This repo uses the genome wide variant effect predictions database produced by the authors of Jun Cheng et al., Accurate proteome-wide missense variant effect prediction with AlphaMissense. Science 0, eadg7492 DOI:10.1126/science.adg7492. [AlphaMissense link](https://www.science.org/doi/10.1126/science.adg7492)

The raw data from AlphaMissense can be downloaded from the data availability section of their paper if needed. The subsequent results from my analysis of their raw file are provided here.

### Snakemake pipeline for average pathogenicity score analysis of any UniProt ID

I have provided a Snakemake pipeline to do the basic steps of subsetting AlphaMissense data, calculating average pathogenicity scores per amino acid, and plotting the average scores per amino acid for that protein. This is meant to work with any UniProt ID, which can be specified in the `workflow/config/config.yaml` file. Users must first install [Snakemake](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html) and both download and unzip the [AlphaMissense raw data file](https://console.cloud.google.com/storage/browser/dm_alphamissense;tab=objects?prefix=&forceOnObjectsSortingFiltering=false) into `data/alphamissense_raw_data/AlphaMissense_aa_substitutions.tsv`. Then, the snakemake pipeline can be run as per standard Snakemake input from within the `workflow/` directory of this repo:
```
snakemake --use-conda --cores 1
```

### ASNS Analysis

To use any of the provided scripts, please install the conda env:
```
conda env create -f workflow/env/asns_variants.yml
```

The database was filtered for those relevant to Asparagine Synthetase (ASNS, UniProt_id P08243, ENST00000394308) using `workflow/scripts/extract_uniprot.sh` and compared to a list of known Asparagine Synthetase Deficiency (ASNSD) associated variants, found in `data/asnsd_variants_raw_data/asnsd_missense_variants.txt`, which were curated from a comprehensive literature search. The results of the literature search for ASNSD mutations are provided in `data/asnsd_variants_raw_data/asnsd_literature_summary.txt`. The known ASNSD variant results from AlphaMissense were found using `workflow/scripts/extract_known_asnsd_alphamissense.sh` and the results are in `results/extracted_alphamissense_known_asnsd_variants.tsv`.

The ASNS protein structure (PDB 6GQ3) was colored in pymol using the script `workflow/scripts/color_structure_pymol.py`, which requires prior use of `workflow/scripts/average_pathogenicity_score_aa.py`. The pymol result was used for `workflow/scripts/add_color_legend_to_pymol.R` to add the legend which corresponds to the average AlphaMissense pathogenicity score predictions from 0 to 1.

![Alt text](/results/color_asns_structure/pathogenic_colored_asns_legend.png?raw=true "ASNS protein structure with amino acids colored by the average AlphaMissense pathogenicity score")

The average pathogenicity score by amino acid position was plotted and colors were overlayed for any amino acid positions with a known ASNSD variant, where the coloring is based on the prediction for that specific variant of the 19 possible. It is important to note that the other variants at this position may have other predictions, but it was chosen to highlight those reported as ASNSD associated variants on top of the plot of all ASNS average scores.

![Alt text](/results/plot_aminoacid_pathogenicity_score_with_asnsd.png?raw=true "Average AlphaMissense pathogenicity score by amino acid position and colored for the prediction at those amino acids with a reported ASNSD variant in the literature")


### Questions

If any issues arise while using my analysis that subsets AlphaMissense predictions for ASNS variant classification with particular focus on ASNSD variants curated from a literature search, then please contact me at staklins@cshl.edu. 

I can assist others that are characterizing ASNS variants and would like help with the AlphaMissense dataset.

### Copyright and license

The raw data is used directly from the community resources provided by AlphaMissense which are under Copyright 2023 DeepMind Technologies Limited.
As required by the use of AlphaMissense data, this repo is licensed under [CC BY-NC-SA 4.0 license](https://creativecommons.org/licenses/by-nc-sa/4.0/)
