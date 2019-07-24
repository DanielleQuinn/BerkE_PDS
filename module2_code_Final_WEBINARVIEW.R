# ---- Slides: Introduction to R ----

# ---- This is a Section Break ----
# Using a number sign tells R that this is a comment
# and not a line of code to be evaluated

# Input goes here
5

# ---- R is a Calculator ----
5 + 6
8 * 7 - 3
9 + 2 / 10

# ---- Conditional Operators ----
3 > 4 # Is 3 greater than 4?
3 <= 4 # Is 3 less than or equal to 4?
3 == 3 # Does 3 equal 3?
3 + 5 == 4 + 6 # Does 3 plus 5 equal 4 plus 6?
!3 == 4 # Does 3 NOT equal 4?

# ---- Functions ----
# Apply a function to find the square root of 81
sqrt(81)

# Nesting functions: what is the square root of the 
# square root of 81?
sqrt(sqrt(81))

# ---- Objects ----
# Print the value of the object called pi
pi
pi * 7
sqrt(pi)

# Give an object called x the value of 5
x <- 5
x

# Give an object called y the value of x plus 10
y <- x + 10
y

# Update the value of x to be 100
x <- 100
x

# Print the value of y
y

# ---- Data Classes ----
# What class of data is in the object called x?
class(x) # The data contained within the object x is numeric

x + 17
sqrt(x)

# What is the square root of "a"?
sqrt("a")

# Class: character
fruit <- "apple" # Need to be in quotes
class(fruit)

fruit + 9
sqrt(fruit)

# Class: logical
purchased <- TRUE
purchased
class(purchased)

returned <- FALSE
returned
class(returned)

purchased + 100
returned + 100

# There are several other classes but these are the most common

# ---- Best Practices of Naming Objects ----
# Can contain letters and numbers
# Must start with a letter
# Can contain . and _ but use with caution and be consistent
# Avoid capitalization; R is case-sensitive and having
# Capital letters increases the likelihood of typos
# Names should be short but informative

# ---- Managing Objects ----
# What happens if we try to print the value of an object that doesn't exist?
a

# Print the names of all objects in your environment
ls()

# Remove an object
rm(x)
ls()

# Remove all objects
rm(list = ls())
ls()

# ---- Slides: Data Structures ----

# ---- Vectors ----
# Create a vector
numbers <- c(1, 5, 2, 4, 16)
numbers

# How many elements are in the vector?
length(numbers)

# What is the average of this vector?
mean(numbers)

# What is the sum of all the elements in this vector?
sum(numbers)

# Conditional operator
3 %in% c(3, 4, 5) # Is 3 found anywhere *in* this vector?

# Add 100 to each element in the vector called numbers
numbers + 100

# Vectors are atomic
vector1 <- c(1, 4, "a")
vector1
class(vector1)

mean(vector1) # What is the average of the elements of vector1?

# Force the values to be treated as numeric
as.numeric(vector1)
class(vector1) # Why does it still say character?

# Overwrite the original object
vector1 <- as.numeric(vector1)
vector1
class(vector1)

# ---- Dealing with NAs ----
# Generate summary statistics of numeric vectors
mean(vector1) # Find the average value
min(vector1) # Find the minimum value
max(vector1) # Find the maximum value

# Tell the function to remove the NAs
mean(vector1, na.rm = TRUE)
min(vector1, na.rm = TRUE)
max(vector1, na.rm = TRUE)

# ---- Indexing ----
# letters is a built-in vector of lower case alphabet
letters

# LETTERS is a built-in vector of upper case alphabet
LETTERS

# Extract the 5th element in LETTERS
LETTERS[5]

# Extract LETTERS 5 to 8
5:8
LETTERS[5:8]

# Extract LETTERS 5, 7, and 10
LETTERS[c(5, 7, 10)]

# ---- Slides: Packages ----

# ---- Data Frames ----
# Install package
install.packages("gapminder") # You only need to install the package once!

# Load package
library(gapminder)

# Access data
data(gapminder)
# or
gapminder <- gapminder::gapminder

# Look at the data
gapminder

# ---- Quality Checks ----
# What are the dimensions (rows, columns) of the data?
dim(gapminder)

# What are the column names of the data?
names(gapminder)

# Print the first six rows of the data
head(gapminder)

# Print the last three rows of the data
tail(gapminder, n = 3)

# Print a summary of each of the columns (vectors) of the data
summary(gapminder)

# Print the column called pop
gapminder$pop

# Print the first five values of the column called lifeExp
gapminder$lifeExp[1:5]

# What class is the column pop?
class(gapminder$pop)

# Check the structure of all columns
str(gapminder)

# ---- Factors ----
class(gapminder$continent)

# Print the levels of the continent column
levels(gapminder$continent)
gapminder$continent
as.numeric(gapminder$continent)