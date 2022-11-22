# IODS assignment 3 data wrangling exercise
# Arto Kekkonen 2022-11-21

library(tidyverse)

student_mat <- read.csv('data/student-mat.csv', header = TRUE, sep = ';')
student_por <- read.csv('data/student-por.csv', header = TRUE, sep = ';')

head(student_mat)
str(student_mat)
dim(student_mat)

head(student_por)
str(student_por)
dim(student_por)

# Note that both data sets have the same columns, so we can do

identifiers <- colnames(student_mat)
free_vars <- c('failures', 'paid', 'absences', 'G1', 'G2', 'G3')
identifiers <- identifiers[!identifiers %in% free_vars]

student_combined <- inner_join(student_mat, student_por, by = identifiers)
str(student_combined)
dim(student_combined)

# Instructions unclear on "getting rid of the duplicate columns",
# but looks like the point is to take their mean

for(col_name in free_vars) {
  
  two_cols <- dplyr::select(student_combined, starts_with(col_name))
  
  first_col <- dplyr::select(two_cols, 1)[[1]]
  
  if(is.numeric(first_col)) {
    student_combined[col_name] <- round(rowMeans(two_cols))
  } else {
    student_combined[col_name] <- first_col
  }
  
}

student_combined <- student_combined %>%
  mutate(alc_use = (Dalc + Walc) / 2) %>%
  mutate(high_use = case_when(alc_use > 2 ~ TRUE,
                              alc_use <= 2 ~ FALSE))

dim(student_combined)

# Looks okay. Note that we're keeping the variables from the
# original two data frames for now, since there's no need
# to remove them.

write_csv(student_combined, 'data/student-combined.csv')
