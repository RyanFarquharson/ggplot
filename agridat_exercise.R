install.packages("agridat")
library(agridat) 
library(tidyverse)
head(blackman.wheat)
bw <- as_tibble(blackman.wheat)
bw

ggplot(data = bw, aes(x = loc, y = yield, colour = nitro)) +
  geom_point() +
  facet_wrap(~type)

ggplot(data = bw, aes(x = gen, y = yield, colour = nitro)) +
  geom_point() +
  facet_wrap(~loc) +
  theme(axis.text.x = element_text(angle = 90))

ggplot(data = bw, aes(x = loc, y = yield, fill = nitro)) +
  geom_col(position = position_dodge(width = 1)) +
  facet_wrap(~gen) +
  theme(axis.text.x = element_text(angle = 90))

ggplot(bw,aes(nitro, yield))+
  geom_line(aes(group = gen)) +
  geom_point() +
  facet_wrap(~loc)

ggsave("figures/alex_plot.png", alex_plot, width = 6, height = 6)
