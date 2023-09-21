# Load required libraries
library(dplyr)
library(gridExtra)
library(grid)
library(png)

missense_predictions_tsv <- "results/extracted_alphamissense_known_asnsd_variants.tsv"
output_file <- "results/table2_missense_predictions_sorted.png"

data <- read.delim(missense_predictions_tsv, header = FALSE, sep = "\t", stringsAsFactors = FALSE, row.names=NULL)

# Rename columns for clarity
colnames(data) <- c("uniprot", "variant", "score", "prediction")

selected_columns <- data %>% select(variant, score, prediction)
png(output_file, width = 900, height = 3100, units = "px", res = 300)
grid.table(selected_columns)
dev.off()
