# Load necessary libraries
library(ggplot2)

Check if a command-line argument (input file path) is provided
args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 2) {
  stop("Usage: Rscript plot_aminoacid_scores.R <input_score_tsv_path> <output_filepath>")
}

score_path <- args[1]
output_filepath <- args[2]

# Read the data from the TSV file
data <- read.table(score_filepath, header = FALSE, sep = "\t")

# Rename columns for clarity
colnames(data) <- c("Amino_Acid_Position", "Pathogenicity_Score")

ggplot(data, aes(x = Amino_Acid_Position, y = Pathogenicity_Score)) +
  geom_point(size = 0.5) +
  facet_wrap(~cut(Amino_Acid_Position, breaks = seq(0, max(Amino_Acid_Position) + 100, by = 100)), nrow = 6, scales = "free_x") +
  theme_minimal() +
  coord_cartesian(clip = "off") +
  labs(x = "Amino Acid Position", y = "Average Pathogenicity Score") +
  scale_x_continuous(breaks = seq(0, max(data$Amino_Acid_Position), by = 10)) +
  theme(
    strip.text.x.top = element_blank(),
    plot.margin = margin(10, 10, 10, 10),
    axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)),
    axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0))) 

ggsave(output_filepath)



### Below can be used to highlight the known ASNSD variants, but it is commented out to permit the above use with any uniprot ID
# score_filepath <- "results/average_pathogenicity_score_aa.tsv"
# output_filepath <- "results/plot_aminoacid_pathogenicity_score_with_asnsd.png"

# # manually input the extracted predictions for known ASNSD variants to color in the plot
# known_asnsd_pathogenic_predicted <- list(6, 48, 49, 75, 123, 133, 138, 145, 205, 243, 247, 254, 263, 289, 337, 340, 362, 366, 370, 373, 389, 404, 475, 480, 489, 519, 550)
# known_asnsd_ambiguous_predicted <- list(75, 398, 267, 428, 475)
# known_asnsd_benign_predicted <- list(80, 380)

# # Read the data from the TSV file
# data <- read.table(score_filepath, header = FALSE, sep = "\t")

# # Rename columns for clarity
# colnames(data) <- c("Amino_Acid_Position", "Pathogenicity_Score")

# # Comment out these few lines just below if not coloring for known variants as with the ASNSD study
# data$known_asnsd <- ifelse(data$Amino_Acid_Position %in% known_asnsd_pathogenic_predicted, "Predicted pathogenic",
#                        ifelse(data$Amino_Acid_Position %in% known_asnsd_ambiguous_predicted, "Predicted ambiguous",
#                               ifelse(data$Amino_Acid_Position %in% known_asnsd_benign_predicted, "Predicted benign", "Not a reported ASNSD variant")))
# known_asnsd_colors <- c("Predicted pathogenic" = "green", "Predicted ambiguous" = "blue", "Predicted benign" = "red", "Not a reported ASNSD variant" = "black")
# legend_order <- c("Predicted pathogenic", "Predicted ambiguous", "Predicted benign", "Not a reported ASNSD variant")

# ggplot(data, aes(x = Amino_Acid_Position, y = Pathogenicity_Score, color = known_asnsd)) +
#   geom_point(size = 0.5) +
#   facet_wrap(~cut(Amino_Acid_Position, breaks = seq(0, max(Amino_Acid_Position) + 100, by = 100)), nrow = 6, scales = "free_x") +
#   theme_minimal() +
#   coord_cartesian(clip = "off") +
#   labs(x = "Amino Acid Position", y = "Average Pathogenicity Score") +
#   scale_x_continuous(breaks = seq(0, max(data$Amino_Acid_Position), by = 10)) +
#   scale_color_manual(values = known_asnsd_colors, name = "Predictions for known\nASNSD variants", limits = legend_order) + 
#   theme(
#     strip.text.x.top = element_blank(),
#     plot.margin = margin(10, 10, 10, 10),
#     axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)),
#     axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
#     legend.title.align = 0.5,
#     legend.key.size = unit(0.5, "lines")
#   ) 

# ggsave(output_filepath)
