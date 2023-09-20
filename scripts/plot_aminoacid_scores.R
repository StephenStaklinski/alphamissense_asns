# Load necessary libraries
library(ggplot2)

# Check if a command-line argument (input file path) is provided
# args <- commandArgs(trailingOnly = TRUE)
# if (length(args) != 2) {
#   stop("Usage: Rscript plot_aminoacid_scores.R <input_score_tsv_path> <output_filepath>")
# }

# score_path <- args[1]
# output_filepath <- args[2]
score_filepath <- "results/average_pathogenicity_score_aa.tsv"
output_filepath <- "results/plot_aminoacid_pathogenicity_score.png"

# Read the data from the TSV file
data <- read.table(score_filepath, header = FALSE, sep = "\t")

# Rename columns for clarity
colnames(data) <- c("Amino_Acid_Position", "Pathogenicity_Score")

ggplot(data, aes(x = Amino_Acid_Position, y = Pathogenicity_Score)) +
  geom_point(size = 0.5) +
  facet_wrap(~cut(Amino_Acid_Position, breaks = seq(0, max(Amino_Acid_Position) + 100, by = 100)), nrow = 6, scales = "free_x") +
  theme_minimal() +
  coord_cartesian(clip = "off") +
  labs(x = "Amino Acid Position", y = "Pathogenicity Score") +
  scale_x_continuous(breaks = seq(0, max(data$Amino_Acid_Position), by = 10)) +
  theme(
    strip.text.x.top = element_blank(),
    plot.margin = margin(10, 10, 10, 10),
    axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)),
    axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)) 
  )

ggsave(output_filepath)
