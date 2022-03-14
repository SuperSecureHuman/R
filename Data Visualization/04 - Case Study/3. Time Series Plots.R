library(tidyverse)
library(dslabs)
data(gapminder)

#Take dataset gapmider
gapminder %>%
  #Pipe it into filter and filter US
  filter(country == "United States") %>%
  #Pipe it into ggplot, and use year and fertility as x and y
  ggplot(aes(year, fertility)) +
  #Use scatter plot
  geom_point(na.rm = TRUE)

# line plot of US fertility by year
gapminder %>%
  filter(country == "United States") %>%
  ggplot(aes(year, fertility)) +
  geom_line(na.rm = TRUE)

# fertility time series for two countries - lines colored by country
#Select Countries
countries <- c("South Korea", "Germany")
#Filter those countries from the dataset
gapminder %>% filter(country %in% countries) %>%
  #Using aes to select year and fertility, and colour it
  ggplot(aes(year, fertility, col = country)) +
  #Plot it
  geom_line()

# life expectancy time series - lines colored by country and labeled, no legend
#Create a data frame labes, with the labels we actually need (here 2 countries)
labels <- data.frame(country = countries, x = c(1975, 1965), y = c(60, 72))
#Filter the dataset
gapminder %>% filter(country %in% countries) %>%
  #Using aes to select year and life_expectancy, and colour it
  ggplot(aes(year, life_expectancy, col = country)) +
  #Plot it
  geom_line() +
  #Add the labels
  geom_text(data = labels, aes(x, y, label = country), size = 5) +
  #No legend
  theme(legend.position = "none")