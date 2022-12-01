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

# That concludes week 4 part. 
# Now let's move on to the week 5 data wranglingassignment.

# Let's load the data and select columns. The resulting data contains information on countries and regions, on the following dimensions:

# * The name of the country (country)
# * The ratio of females with at least secondary education to similar males (seced_ratio)
# * The ratio of female labour force participation rate to the male equivalent (lfpr_ratio)
# * Years of education that a people living in the country is expected to undergo (eye)
# *Life expectancy at birth (leb)
# * Gross National Income (GNI) (gni)
# * Maternal mortality rate (mmr)
# * Adolescent birth rate (abr)
# * Percentage of female representatives in parliament (prc_parliament)

# We also remove all rows with missing values, 
# and observations that correspond to regions instead of countries 
# (these are the last seven rows of the data frame)

data <- read.csv('data/human.csv') %>%
  dplyr::select(country, seced_ratio, lfpr_ratio, eye, leb, gni, mmr, abr, prc_parliament) %>%
  na.omit() %>%
  slice_head(n = -7)

rownames(data) <- data$country
data <- data %>% dplyr::select(-country)

write.csv(data, 'data/human2.csv', row.names = TRUE)