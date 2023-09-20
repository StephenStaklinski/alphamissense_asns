## Comparative analysis of ASNS variant pathogenicity predictions by AlphaMissense and known ASNSD associated variants in the literature

The goals of this repo are to:

    1. perform a comparative analysis of predicted ASNS variant effects to known effects in the ASNSD literature
    2. simplify the accessibility of data from AlphaMissense predictions for use by those caring for patients with a potential diagnosis of ASNSD.

### AlphaMissense

This repo uses the genome wide variant effect predictions database produced by the authors of Jun Cheng et al., Accurate proteome-wide missense variant effect prediction with AlphaMissense. Science 0, eadg7492 DOI:10.1126/science.adg7492. [AlphaMissense link](https://www.science.org/doi/10.1126/science.adg7492)

The raw data from AlphaMissense can be downloaded the data availability of their paper if needed. Subsequent results from my analysis of their raw file is provided here.

### Analysis

To use any of the provided scripts, please install the conda env:
```
conda env create -f env/asns_variants.yml
```

The database was filtered for those relevant to Asparagine Synthetase (ASNS, UniProt_id P08243, ENST00000394308) using `scripts/extract_uniprot.sh` and compared to a list of known Asparagine Synthetase Deficiency (ASNSD) associated variants, found in `data/asnsd_variants_raw_data/asnsd_missense_variants.txt`, curated a comprehensive literature search. The results of the literature search for ASNSD mutations are provided in `data/asnsd_variants_raw_data/asnsd_literature_summary.txt`. The known ASNSD variant results from AlphaMissense were found using `scripts/extract_known_asnsd_alphamissense.sh` and the results are in `results/extracted_alphamissense_known_asnsd_variants.tsv`.

The ASNS protein (PDB 6GQ3) was colored in pymol using the script `scripts/color_structure_pymol.py`, which requires prior use of `scripts/average_pathogenicity_score_aa.py` and the result was input to `scripts/add_color_legend_to_pymol.R` to add the legend which corresponds the the AlphaMissense pathogenicity score predictions from 0 to 1.

![Alt text](/results/color_asns_structure/pathogenic_colored_asns_legend.png?raw=true "ASNS protein structure with amino acids colored by the average AlphaMissense pathogenicity score")


### Questions

If any issues arise using this basic repo that subsets AlphaMissense predictions for ASNS variant classification with particular focus on ASNSD variants curated from a literature search, then please contact me at staklins@cshl.edu. 

I am glad to assist others that are characterizing ASNS variants and could use assistance with the AlphaMissense dataset.

### Copyright and license

The raw data for AlphaMissense is under Copyright 2023 DeepMind Technologies Limited.
This repo is licensed under [CC BY-NC-SA 4.0 license] (https://creativecommons.org/licenses/by-nc-sa/4.0/)