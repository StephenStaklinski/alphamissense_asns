# Load required libraries
library(dplyr)
library(gridExtra)
library(grid)
library(png)

lit_review_csv <- "data/asnsd_variants_raw_data/asnsd_literature_summary.csv"
output_file <- "results/table1_literature_review.png"

data <- read.delim(lit_review_csv, header = FALSE, sep = ",", stringsAsFactors = FALSE, row.names=NULL, comment="#")

# Rename columns for clarity
colnames(data) <- c("Variants (Mutations)", "Genotype", "Reference")

png(output_file, width = 4500, height = 3800, units = "px", res = 300)
grid.table(data)
dev.off()
