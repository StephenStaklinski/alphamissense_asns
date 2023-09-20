# Comparative analysis of ASNS variant pathogenicity predictions and known ASNSD associated variants

The goals of this repo are to:
    1. perform a comparative analysis of predicted ASNS variant effects to known effects in the ASNSD literature
    2. simplify the accessibility of data from AlphaMissense predictions for the use by clinicians caring for patients with a potential diagnosis of ASNSD.

This repo uses the genome wide variant effect predictions database produced by the authors of Jun Cheng et al., Accurate proteome-wide missense variant effect prediction with AlphaMissense. Science 0, eadg7492 DOI:10.1126/science.adg7492 [https://www.science.org/doi/10.1126/science.adg7492]. 

The database was filtered for those relevant to Asparagine Synthetase (ASNS, UniProt_id P08243, ENST00000394308) and compared to a list of known Asparagine Synthetase Deficiency (ASNSD) associated variants from a comprehensive literature search. The results of the literature search for ASNSD mutations are provided here.

The ASNS protein (PDB 6GQ3) was colored in pymol using the script `scripts/color_structure_pymol.py` and the result was input to `scripts/add_color_legend_to_pymol.R` to add the legend which corresponds the the AlphaMissense pathogenicity score predictions from 0 to 1.

If any issues arise using this basic repo that subsets AlphaMissense predictions for ASNS variant classification with particular focus on ASNSD variants curated from a literature search, then please contact me at staklins@cshl.edu. I am glad to assist others that are characterizing ASNS variants, but not experienced in computational techniques to work with the provided datasets.