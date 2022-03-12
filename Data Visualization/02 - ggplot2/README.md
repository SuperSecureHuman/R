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

### Layers

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

#### Tweaking our plot further

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


### Scale

By default, ggplot scales the data to fit the plot. But in this case, we need a log plot. Lets do that

Convert the x-axis to log scale with scale_x_continuous(trans = "log10") or scale_x_log10(). Similar functions exist for the y-axis.

```R
#Converting to log scale
# log base 10 scale the x-axis and y-axis
p + geom_point(size = 3) +
    geom_text(nudge_x = 0.05) +
    scale_x_continuous(trans = "log10") +
    scale_y_continuous(trans = "log10")
    
# efficient log scaling of the axes
p + geom_point(size = 3) +
    #Since the plot is smaller, we use a smaller nudge
    geom_text(nudge_x = 0.075) +
    #Here is the short method of the same scale
    scale_x_log10() +
    scale_y_log10()
```

Since log_10 is a really common scale, ggplot has a predifined scale called `scale_x_log10()` and `scale_y_log10()` to make it easier.

### Labels and Titles

Add axis titles with `xlab()` and `ylab()` functions. Add a plot title with the `ggtitle()` function.

Lets see an example

```R
#We are using the previous plot

p + geom_point(size = 3) +
    geom_text(nudge_x = 0.075) +
    scale_x_log10() +
    scale_y_log10() +
    #X-axis label
    xlab("Population in millions (log scale)") +
    #Y-axis label
    ylab("Total number of murders (log scale)") +
    #Plot title
    ggtitle("US Gun Murders in 2010")
```

### Coloring the plot

Coloring the plot is done usually by passing an argument within the layer you want to colour.

```R
...
...
# make all points blue
p + geom_point(size = 3, color = "blue")

# color points by region
p + geom_point(aes(col = region), size = 3)
...
...
```

### Drawing a line 

Now we will try to add a line, that will show the average murder rate of the dataset.

```R
# define average murder rate
r <- murders %>%
    summarize(rate = sum(total) / sum(population) * 10^6) %>%
    pull(rate)
    
# basic line with average murder rate for the country
p <- p + geom_point(aes(col = region), size = 3) +
    geom_abline(intercept = log10(r))    # slope is default of 1
    
# change line to dashed and dark grey, line under points
p + 
    geom_abline(intercept = log10(r), lty = 2, color = "darkgrey") +
    geom_point(aes(col = region), size = 3)
```

### Additonal Touches

The style of a ggplot graph can be changed using the `theme()` function.

The `ggthemes` package adds additional themes.

Sometimes, when adding labels, they might overlap with other labels. To avoid this, we use a layer named `geom_text_repel()` provided by ggrepel library.

You can now look at the complete plot here - [Complete Plot](./5.Theming.R)

## Other plots in ggplot

### Histograms

Histogram's layer is `geom_histogram()`

```R
# load heights data
library(tidyverse)
library(dslabs)
data(heights)

# define p
p <- heights %>%
    filter(sex == "Male") %>%
    ggplot(aes(x = height))
    
# basic histograms
p + geom_histogram()
p + geom_histogram(binwidth = 1)

# histogram with blue fill, black outline, labels and title
p + geom_histogram(binwidth = 1, fill = "blue", col = "black") +
    xlab("Male heights in inches") +
    ggtitle("Histogram")
```

### Smooth density plots

```R
library(tidyverse)
library(dslabs)
data(heights)

# define p
p <- heights %>%
    filter(sex == "Male") %>%
    ggplot(aes(x = height))

p + geom_density()
p + geom_density(fill = "blue")
```

### Quantile-quantile plots

```R
library(tidyverse)
library(dslabs)
data(heights)

# basic QQ-plot
p <- heights %>% filter(sex == "Male") %>%
    ggplot(aes(sample = height))
p + geom_qq()

# QQ-plot against a normal distribution with same mean/sd as data
params <- heights %>%
    filter(sex == "Male") %>%
    summarize(mean = mean(height), sd = sd(height))
    p + geom_qq(dparams = params) +
    geom_abline()
    
# QQ-plot of scaled data against the standard normal distribution
heights %>%
    ggplot(aes(sample = scale(height))) +
    geom_qq() +
    geom_abline()
```