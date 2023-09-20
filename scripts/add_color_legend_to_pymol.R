library(ggplot2)
library(cowplot)

# Check if a command-line argument (input file path) is provided
# args <- commandArgs(trailingOnly = TRUE)
# if (length(args) != 2) {
#   stop("Usage: Rscript add_legend_to_image.R <input_pymol.png> <output_filepath>")
# }

# pymol_png <- args[1]
# output_filepath <- args[2]
pymol_png <- "results/color_asns_structure/pathogenic_colored_asns.png"
output_filepath <- "results/color_asns_structure/pathogenic_colored_asns_legend.png"

data <- data.frame(
  x = 1:10,
  y = 1:10,
  value = seq(0, 1, length.out = 10)  # Values from 0 to 1
)

legend_plot <- ggplot(data, aes(x, y, fill = value)) +
  geom_point(aes(fill = 0), shape = NA) +
  scale_fill_gradientn(
    colours = c("blue", "white", "red"),  # Define the colors
    values = scales::rescale(c(0, 1)),   # Map 0 to blue and 1 to red
    limits = c(0, 1),                     # Set the scale limits
    guide = guide_colorbar()              # Add a color legend
  ) +
  theme_void() +
  labs(fill = "") +
  theme(legend.position = "right", 
  legend.justification = "center",
  legend.text = element_text(size = 12))

ggdraw() +
  draw_image(pymol_png, scale=1.8) +    ### adjust scale depending on size of pymol png
  draw_plot(legend_plot, scale=0.9)

ggsave(output_filepath)
