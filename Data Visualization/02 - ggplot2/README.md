# ggplot

Keep this cheat sheet handy [R-Cheatsheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/rstudio-ide.pdf)

We will go through ggplot, by making a plot, piece by piece

First, we start off by importing the required libraries

```R
#Tidyverse includes ggplot and dplyr along with some more useful libraries
library(tidyverse)
library(dslabs)
data(murders)
```

Next, we have to associate a ggplot object with a data set. This can be done in the following ways

```R
#Assuming your data set is 'x'
ggplot(data = x)
ggplot(x)
x %>% ggplot()
#You can use any one command to initializse the object
```

After this is done, a graphics will be rendered. A blank one.

One more way we can effectively use ggplot is by assiging plots to variables. Take a look at this code

```R
p <- ggplot(data = x)

print(p)

#now by printing 'p', you can see a blank graphics being rendered.
```

## Layers

In ggplot, graphs are created by adding layers

Layers can define geometries, compute statistics and more.

In general, the syntax of plotting with layers will look something like this `data %>% ggplot() + LAYER1 + LAYER2 +.....`

Usually, the first layer, defines the geometry of the plot.

Lets try to do a scatter plot

Looking at the docs, we get to know that for a scatter plot, its `geom_point()`

Further the docs say that it can take in multiple args.

To actually plot anything, we have to use something called aem() (asthetic mapping). This is the function that connects the data to the plot.

```R
# add points layer to predefined ggplot object
p <- ggplot(data = murders)
#adding a layer, look at the usage of the aes()
p + geom_point(aes(population/10^6, total))

#Output will be a plot
```

Now we will add a layer, that will label each point. For this we have to use `geom_text()` layer.

```R
p + geom_point(aes(population/10^6, total)) +
# add text layer to scatterplot
#Note that you define the label inside of the aes(). This is what ggplot needs
    geom_text(aes(population/10^6, total, label = abb))
```


`geom_text()` and `geom_label()` add text to a scatterplot and require x, y, and label aesthetic mappings.

To determine which aesthetic mappings are required for a geometry, read the help file for that geometry.

You can add layers with different aesthetic mappings to the same graph.

### Tweaking our plot further

```R
#Setting the size of the points
p + geom_point(aes(population/10^6, total), size = 3) +
# move text labels slightly to the right
    geom_text(aes(population/10^6, total, label = abb), nudge_x = 1)
```

We can simplify this further by using global asthetic mapping. What we do is, when creating the object, we can specify the aesthetic mappings.
Then add layers as shown below.


```R
# simplify code by adding global aesthetic
p <- murders %>% ggplot(aes(population/10^6, total, label = abb))
p + geom_point(size = 3) +
    geom_text(nudge_x = 1.5)
    
# local aesthetics override global aesthetics
p + geom_point(size = 3) +
#Here, we are assigning a local aesthetic to the text layer, which overrides the global aesthetic
    geom_text(aes(x = 10, y = 800, label = "Hello there!"))
```


## Scale

By default, ggplot scales the data to fit the plot. But in this case, we need a log plot. Lets do that

Convert the x-axis to log scale with scale_x_continuous(trans = "log10") or scale_x_log10(). Similar functions exist for the y-axis.