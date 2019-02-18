library(readr)
au_per_paper <- read_delim("data/au_per_paper.txt", 
                           "\t", escape_double = FALSE, trim_ws = TRUE)

# Basic descriptives
require(plyr)
desc <- ddply(au_per_paper, "univ", summarise, mean = mean(au), median = median(au),
      sd = sd(au))

library(ggplot2)
ggplot(au_per_paper, aes(x=au, color=univ)) +
#  geom_density() +
  geom_histogram(aes(y=..density..), alpha=0.1, 
                 position="identity", bins = 50) +
  scale_x_continuous(trans = "log10") +
  geom_vline(data=desc, aes(xintercept = median, color = univ), linetype = "dashed") +
  scale_color_brewer(palette="Dark2") +
  labs(tag = "A") +
  theme_minimal() +
  facet_grid(univ~.)
