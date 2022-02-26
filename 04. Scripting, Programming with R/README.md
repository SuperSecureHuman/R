# Programming in R

Here, we will go through 3 main programming concepts - conditionals, for-loops and functions.

## Conditionals

Lets try a basic if-else block. 

```R
# Define a  variable
a <- 0

# if a is not equal to 0, print the inverse of a
if(a!=0){
  print(1/a)
} 
# if the prev check failed (ie a = 0), the else statement will be executed
else{
  print("No reciprocal for 0.")
}
```

The `ifelse()` block in R is powerfull. It takes in 3 args - the condition, the true statement and the false statement.

This can be really powerful when used on vectors

```R
# the ifelse() function works similarly to an if-else conditional
a <- 0
ifelse(a > 0, 1/a, NA)

# the ifelse() function is particularly useful on vectors
a <- c(0,1,2,-4,5)
result <- ifelse(a > 0, 1/a, NA)

# the ifelse() function is also helpful for replacing missing values
data(na_example)
no_nas <- ifelse(is.na(na_example), 0, na_example) 
sum(is.na(no_nas))
```

```R
# the any() and all() functions evaluate logical vectors
z <- c(TRUE, TRUE, FALSE)
#Retrurn true if any one is true
any(z)
#Return true only if all are true
all(z)
```

## Functions

Lets write a function to compute mean of a data set

```R

avg <- function(x){
  s <- sum(x)
  l <- length(x)
  s/l
}

#Now you can call avg function, with a vector as input, and it will return the average of the vector

```

## For Loops

For-loops perform the same task over and over while changing the variable.  They let us define the range that our variable takes, and then changes the value with each loop and evaluates the expression every time inside the loop.

The general form of a for-loop is: "For i in [some range], do operations".  This i changes across the range of values and the operations assume i is a value you're interested in computing on.

At the end of the loop, the value of i is the last value of the range.

