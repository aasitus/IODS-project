# This script created by Arto Kekkonen on 2022-11-11
# for the IODS week 2 assignment

library(tidyverse)

data <- read.table('data/JYTOPKYS3-data.txt', header = TRUE, sep = '\t')

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", 
               "D22", "D30", "D06", "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", 
                       "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25",
                         "ST04","ST12","ST20","ST28")

d <- data %>%
  mutate(Attitude = Attitude / 10) %>%
  rowwise() %>%
  mutate(deep = mean(c_across(all_of(deep_questions)))) %>%
  mutate(stra = mean(c_across(all_of(strategic_questions)))) %>%
  mutate(surf = mean(c_across(all_of(surface_questions)))) %>%
  rename(points = Points) %>%
  dplyr::filter(points != 0) %>%
  dplyr::select(age = Age, gender, attitude = Attitude,
                deep, stra, surf, points)

write_csv(d, 'data/learning2014.csv')

new_d <- read_csv('data/learning2014.csv')

str(new_d)
head(new_d)
