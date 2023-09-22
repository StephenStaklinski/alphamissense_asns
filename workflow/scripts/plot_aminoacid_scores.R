# Load necessary libraries
library(ggplot2)


# args <- commandArgs(trailingOnly = TRUE)
# if (length(args) != 2) {
#   stop("Usage: Rscript plot_aminoacid_scores.R <input_score_tsv_path> <output_filepath>")
# }

# score_filepath <- args[1]
# output_filepath <- args[2]

# Read the data from the TSV file
data <- read.table(score_filepath, header = FALSE, sep = "\t")

# Rename columns for clarity
colnames(data) <- c("Amino_Acid_Position", "Pathogenicity_Score")

ggplot(data, aes(x = Amino_Acid_Position, y = Pathogenicity_Score)) +
  geom_point(size = 0.5) +
  facet_wrap(~cut(Amino_Acid_Position, breaks = seq(0, max(Amino_Acid_Position) + 100, by = 100)), nrow = 6, scales = "free_x") +
  theme_bw() +
  coord_cartesian(clip = "off") +
  labs(x = "Amino Acid Position", y = "Average Pathogenicity Score") +
  scale_x_continuous(breaks = seq(0, max(data$Amino_Acid_Position), by = 10)) +
  theme(
    panel.border = element_blank(),
    strip.text.x.top = element_blank(),
    plot.margin = margin(10, 10, 10, 10),
    axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)),
    axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
    plot.background = element_rect(fill = "white")) 

ggsave(output_filepath)

