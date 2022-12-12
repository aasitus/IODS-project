library(tidyverse)

bprs <- read.table('https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt',
                   sep = ' ', header = TRUE)
rats <- read.table('https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt',
                   sep = '\t', header = TRUE)

colnames(bprs)
head(bprs)
str(bprs)
glimpse(bprs)

colnames(rats)
head(rats)
str(rats)
glimpse(rats)

bprs <- bprs %>%
  dplyr::mutate(treatment = as.factor(treatment),
                subject = as.factor(subject))

rats <- rats %>%
  dplyr::mutate(ID = as.factor(ID),
                Group = as.factor(Group))

bprsl <- bprs %>%
  pivot_longer(cols = -c(treatment, subject), 
               names_to = 'week', values_to = 'bprs') %>%
  arrange(week) %>%
  dplyr::mutate(week = as.integer(substr(week, 5, 5)))

ratsl <- rats %>%
  pivot_longer(cols = -c(ID, Group),
               names_to = 'wd',
               values_to = 'weight') %>%
  dplyr::mutate(time = as.integer(substr(wd, 3, 5))) %>%
  arrange(time) %>%
  dplyr::select(-wd)

# Now, comparing just rats to ratsl,
# we can note that whereas the original table contains
# a row for each rat and a column for its weight each day,
# the long-form table contains a row for each rat each day,
# i.e. as many rows per rat as there are days

colnames(rats)
colnames(ratsl)

head(rats)
head(ratsl)

summary(rats)
summary(ratsl)

# This means that e.g. a summary of weight takes each rat
# into account a number of times.

# Let's write the data in files

write_csv(bprsl, 'data/bprls.csv')
write_csv(ratsl, 'data/ratsl.csv')
