library(tidyverse)
a_bandlist_raw <- read_csv("data/A_bandlist.csv")
a_bandlist_raw
glimpse(a_bandlist_raw)

summarize_all(a_bandlist_raw, n_distinct)

count(a_bandlist_raw, Species)
count(a_bandlist_raw, Health_status)
count(a_bandlist_raw, Canopy_status)

a_bandlist <- a_bandlist_raw %>% 
  select(-X1) %>% 
  mutate(
    Species = factor(Species) %>% 
      fct_recode("FAGR" = "FAGR#"),
    Health_status = factor(Health_status, c("L", "M")) %>% 
      fct_recode("alive" = "L", "dead" = "M"),
    Canopy_status = factor(Canopy_status, c("OS", "OD", "UN")) %>% 
      fct_recode("canopy" = "OS", "subcanopy" = "OD", "understory" = "UN")
  )
a_bandlist

species_summary <- a_bandlist %>% 
  group_by(Species) %>% 
  summarize(
    mean_DBH_cm = mean(DBH_cm),
    frac_alive = mean(Health_status == "alive"),
    frac_understory = mean(Canopy_status == "understory")
  )
species_summary

ggplot(a_bandlist) +
  aes(x = SubplotID, y = DBH_cm, fill = Species) +
  geom_boxplot() +
  ylab("DBH (cm)") +
  xlab("Subplot") +
  scale_fill_brewer(palette = "Set2") +
  theme_minimal()
