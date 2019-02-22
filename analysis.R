library(tidyverse)
a_bandlist_raw <- read_csv("data/A_bandlist.csv")
a_bandlist_raw
glimpse(a_bandlist_raw)
ggplot(a_bandlist) +
  aes(x = SubplotID, y = DBH_cm, fill = Species) +
  geom_boxplot()
