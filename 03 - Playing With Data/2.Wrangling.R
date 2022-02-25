library(dplyr)

# adding a column with mutate
library(dslabs)
data("murders")
murders <- mutate(murders, rate = total / population * 100000)

#Filtering the data based on murder_rate
filter(murders, rate <= 0.71)

#Creating a table, based on spefic column names
new_table <- select(murders, state, region, rate)

#Filtering on the new table
filter(new_table, rate <= 0.71)

#Using the pipe function
murders %>% select(state, region, rate) %>% filter(rate <= 0.71)