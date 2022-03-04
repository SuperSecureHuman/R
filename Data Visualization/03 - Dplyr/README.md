# Dplyr

## `summarize()` function

This function in R, helps us provide a summary of the data, with more intuitive and readable code.

```R
# compute average and standard deviation for males

#Use the heights dataset
s <- heights %>%
    #Filter only male
    filter(sex == "Male") %>%
    #Using summarize to summerize. Note that we can use custom column names for the output.
    summarize(average = mean(height), standard_deviation = sd(height))
```

The result is stored in a data frame. Thus allowing us to access the elemnts with the `$` operator.

```R
# access average and standard deviation from summary table
s$average
s$standard_deviation
```

`summarize()` can compute any summary function that operates on vectors and returns a single value, but it cannot operate on functions that return multiple values.

Like most dplyr functions, `summarize()` is aware of variable names within data frames and can use them directly.


Usually, most of the dplyr functions return data frames. The dot operator allows dplyr functions to return single vectors or numbers instead of only data frames.

`us_murder_rate %>% .$rate` is equivalent to `us_murder_rate$rate`.


## Group By

Dplyr functions act differently when we use it against a grouped dataframe.

Lets see an example

```R
heights %>%
    group_by(sex)
```

Here, you are grouping the heights dataframe by sex.

Now when trying to summarize that data.


```R
> heights %>%
+   group_by(sex) %>%
+   summarize(average = mean(height), standard_deviation = sd(height))
# A tibble: 2 × 3
  sex    average standard_deviation
  <fct>    <dbl>              <dbl>
1 Female    64.9               3.76
2 Male      69.3               3.61
```


## Sorting

The `arrange()` function from dplyr sorts a data frame by a given column.

```R
# arrange by population column, smallest to largest
murders %>% arrange(population) %>% head()

# arrange by murder rate in descending order
murders %>% arrange(desc(murder_rate)) %>% head()
```

We can sort based on multiple columns like this

```R
# arrange by region alphabetically, then by murder rate within each region
murders %>% arrange(region, murder_rate) %>% head()
```

We can show the top/bottom n rows like this

```R
# show the top 10 states with highest murder rate, not ordered by rate
murders %>% top_n(10, murder_rate)

# show the top 10 states with highest murder rate, ordered by rate
murders %>% arrange(desc(murder_rate)) %>% top_n(10)

# alternatively, can use the slice_max function
murders %>% slice_max(murder_rate, n = 10)
```


