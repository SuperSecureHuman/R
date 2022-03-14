library(tidyverse)
library(dslabs)
data(murders)
p <- murders %>% ggplot(aes(population/10^6, total, label = abb))

p + geom_point(size = 3) +
  geom_text(nudge_x = 0.075) +
  scale_x_log10() +
  scale_y_log10() +
  #X-axis label
  xlab("Population in millions (log scale)") +
  #Y-axis label
  ylab("Total number of murders (log scale)") +
  #Plot title
  ggtitle("US Gun Murders in 2010")

