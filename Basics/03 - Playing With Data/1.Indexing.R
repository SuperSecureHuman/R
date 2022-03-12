library(dslabs)
data(murders)

#Defining Murder Rate
murder_rate <- murders$total / murders$population * 100000

#Getting index of each location where murder rate is less than or equal to 0.71
index <- murder_rate <= 0.71

#Getting the states where the index is TRUE
murders$state[index]

#Seeing how many states have that murder rate condition we specified
sum(index)

#Now we will try to apply multiple conditions with logical operators

#Dertermining if the state is in west
west <- murders$region == "West"

#Seeing if the murder rate is less than 1
safe <- murder_rate <= 1

#Checking if its safe, and its in west
index <- safe & west

#Checking which states satisfy our need
murders$state[index]


#Lets tryout the match function

# to obtain the indices and subsequent murder rates of New York, Florida, Texas, we do:
index <- match(c("New York", "Florida", "Texas"), murders$state)
#Checking the index
index
#Verifying the state names
murders$state[index]
#Checking their murder rates
murder_rate[index]

#%in% function

x <- c("a", "b", "c", "d", "e")
y <- c("a", "d", "f")
#Now we will check which elements of y are available in x
y %in% x

# to see if Boston, Dakota, and Washington are states
c("Boston", "Dakota", "Washington") %in% murders$state

