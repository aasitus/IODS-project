library(tidyverse)

hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

str(hd)
str(gii)

summary(hd)
summary(gii)

colnames(hd) <- c('rank', 'country', 'hdi', 'leb', 'eye', 'mye', 'gni', 'gni_hdi')
colnames(gii) <- c('rank', 'country', 'gii', 'mmr', 'abr', 'prc_parliament', 'seced_f', 'seced_m', 'lfpr_f', 'lfpr_m')

gii$seced_ratio <- gii$seced_f / gii$seced_m
gii$lfpr_ratio <- gii$lfpr_f / gii$lfpr_m

combined <- dplyr::inner_join(hd, gii, by = 'country')

write_csv(combined, 'data/human.csv')