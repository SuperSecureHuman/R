#Import libraries

library(tidyverse)
library(dslabs)
data(murders)


#Initilaise the ggplot object
#Either of the lines are right
ggplot(data = murders)
murders %>% ggplot()

#Assiging the plot to a variable, and seeing how it works
p <- ggplot(data = murders)
class(p)
print(p)    # this is equivalent to simply typing p
p

# add points layer to predefined ggplot object
p <- ggplot(data = murders)
#adding a layer, look at the usage of the aes()
p + geom_point(aes(population/10^6, total)) +
  # add text layer to scatterplot
  #Note that you define the label inside of the aes(). This is what ggplot needs
  geom_text(aes(population/10^6, total, label = abb))

#Setting the size of the points
p + geom_point(aes(population/10^6, total), size = 3) +
  # move text labels slightly to the right
  geom_text(aes(population/10^6, total, label = abb), nudge_x = 1)

# simplify code by adding global aesthetic
p <- murders %>% ggplot(aes(population/10^6, total, label = abb))
p + geom_point(size = 3) +
  geom_text(nudge_x = 1.5)

# local aesthetics override global aesthetics
p + geom_point(size = 3) +
  #Here, we are assigning a local aesthetic to the text layer, which overrides the global aesthetic
  geom_text(aes(x = 10, y = 800, label = "Hello there!"))