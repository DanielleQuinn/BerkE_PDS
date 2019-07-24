# ---- Slides: Introduction to R ----

# ---- This is a Section Break ----
# This will be your .R script
# It can be used to re-run an analysis and can be saved 
# between coding sessions

# Using a number sign tells R that this is a comment
# and not a line of code to be evaluated

# There are two ways to specificy what piece of code you 
# want to run:
# Option 1: Highlight the code
# Option 2: Put your cursor anywhere on the line of code

# There are also two common ways of running a line 
# of code:
# Option 1: Click on"Run" in the upper right hand corner of
# this window
# Option 2: On Windows, use Ctrl-Enter. On Macs, use
# Cmd-Enter

# Input goes here
5

# The given input and the resulting output
# will appear in the Console, below.

# In the lower left hand corner of the Console window
# if you see > it means that R is ready to go
# if you see   it means that R is processing something
# if you see + it means that R requires more information
# To reset back to >, click in the Console and hit Esc

# ---- R is a Calculator ----
# R follows standard order of operations
5 + 6
8 * 7 - 3
9 + 2 / 10 # Spaces don't influence the code itself but
           # are important for code readability

# ---- Conditional Operators ----
# Statements that return logical values (TRUE or FALSE)
3 > 4 # Is 3 greater than 4?
3 <= 4 # Is 3 less than or equal to 4?
3 == 3 # Does 3 equal 3?
3 + 5 == 4 + 6 # Does 3 plus 5 equal 4 plus 6?
!3 == 4 # Does 3 NOT equal 4?

# In later modules you'll learn more about combining multiple conditional
# operators to subset data frames using a package called {dplyr}

# ---- Functions ----
# What if we wanted to do more complex operations?
# What if we want to find the square root of 81?
# R has functions! Functions *do things*

sqrt(81) # This is the square root function

# You can recognize a function because it is a 
# word or series of characters followed by (
# Every open bracket ( needs a closing bracket )
# The information that goes inside of the brackets
# is called the "argument".
# Functions can have one to many arguments, with some
# of the arguments required and some optional.

# Functions can be nested. When nested, they are
# evaluated from the innermost function out.

sqrt(sqrt(81)) # What is the square root of the square root of 81?

# R comes with a wide range of standard functions.

# ---- Objects ----
# In addition to functions, R has some handy built-in
# values, like pi, which is 3.1415

# Here, the value is stored in an object called pi and
# can be called on at any point and treated like
# a regular number
pi
pi * 7
sqrt(pi)

# A key task in R is to create, use, and modify your
# own objects
# A value can be assigned to an object using the assignment
# operator <-

# Give an object called x the value of 5
x <- 5 # Assigns the value to x
x # Prints the value of x

# Give an object called y the value of x plus 10
y <- x + 10
y

# Update the value of x to be 100
x <- 100
x

# Print the value of y
y

# Notice that the value of y did not automatically
# update with the new value of x; this might be
# different than other programming languages you
# may have tried.

# This means that the order you write and run
# your code in is very important.

# ---- Data Classes ----
# Objects have attributes that give us more information
# about them and what we are able to do with them

# A key attribute is class
# What class of data is in the object called x?
class(x) # The data contained within the object x is numeric

# This is why we've been able to treat it as a number
x + 17
sqrt(x)

# Typically functions only accept arguments of a specific class.
# For example, running
sqrt("a") # What is the square root of "a"?
# will obviously give us an error with a meaningful 
# message; "non-numeric arguent to mathematical function".
# Sometimes error messages are more cryptic and you may
# need to Google them to learn more about what went wrong.

# Class: character
# These are essentially words or 'strings'
fruit <- "apple" # Need to be in quotes
class(fruit)

# Of course, we can't treat fruit as a number...
fruit + 9
sqrt(fruit)

# Class: logical
# Another common class is logical
# TRUE and FALSE are built-in logical values
purchased <- TRUE
purchased
class(purchased)

returned <- FALSE
returned
class(returned)

# There are several other classes but these are the most common

# We'll be using these classes throughout this course
# and will see how data class influences our data and
# analysis scripts

# At the moment our objects are the simplest data structure,
# "scalar", which contain a single value. We'll explore
# more complicated data structures soon.

# ---- Best Practices of Naming Objects ----
# Can contain letters and numbers
# Must start with a letter
# Can contain . and _ but use with caution and be consistent
# Avoid capitalization; R is case-sensitive and having
# capital letters increases the likelihood of typos
# Names should be short but informative

# ---- Managing Objects ----
# What happens if we try to print the value of an object that doesn't exist?
a

# The error tells us that there is no object called a

# To print the names of all of the objects that exist
# in your environment (not including built-in objects like pi)
ls()

# To remove an object
rm(x)

# We can confirm it has been removed
ls()

# To remove all objects
rm(list = ls())

# Confirm all objects have been removed
ls()

# ---- Slides: Data Structures ----

# Now that we've learned a little about data structures
# let's explore some of the ways we interact with them

# ---- Vectors ----
# Vectors are multiple elements
# of the same data class and can be built using
# the combine function c()

# Create a vector
numbers <- c(1, 5, 2, 4, 16) # No output
numbers # Shows you the contents of the object

# How many elements are in the vector?
length(numbers)

# What is the average of this vector?
mean(numbers)

# What is the sum of all the elements in this vector?
sum(numbers)

# Using vectors requires a new conditional operator, %in%
3 %in% c(3, 4, 5) # Is 3 found anywhere *in* this vector?

# You can do something to each element of a vector
# Add 100 to each element in the vector called numbers
numbers + 100

# This becomes handy when we start dealing with
# data frames, where each column is a vector

# Vectors are atomic, which means that every
# element in a vector must be of the same class
# If you try to mix classes (for example, numeric and
# character), they will be coerced into the same class
vector1 <- c(1, 4, "a")
vector1
mean(vector1)
class(vector1)
# Why do the numbers become characters?
# It is easier to treat numbers as characters than 
# characters as numbers
# There is a hierarchy that is used for coercing vectors

# Force the values to be treated as numeric
as.numeric(vector1)
# Why is the third element NA?
# Warning message tells you that some values will be
# treated as missing or null values because R is not
# able to coerce the letter "a" into a numeric value

class(vector1) # Why does it still say character?
# The function only shows you what it would look like
# if the vector was numeric, it doesn't actually
# make that change. To make a permanent change, 
# you need to overwrite the original object
vector1 <- as.numeric(vector1)
class(vector1)

# ---- Dealing with NAs ----
# How do NAs influence the way we deal with vectors?
# There are many functions that are used to generate summary
# statistics of numeric vectors
mean(vector1) # Find the average value
min(vector1) # Find the minimum value
max(vector1) # Find the maximum value
# All of these return NA because the function doesn't know
# what to do when there is a missing value in the vector

# Most of these functions have a built in
# optional argument that can be used to tell the function
# to remove the NAs before it performs its calculations
mean(vector1, na.rm = TRUE)
min(vector1, na.rm = TRUE)
max(vector1, na.rm = TRUE)

# ---- Indexing ----
# Indexing is a method of exploring an object in R
# The way that it is used depends on the structure of the object

# letters is a built-in vector of lower case alphabet
letters

# LETTERS is a built-in vector of upper case alphabet
LETTERS

# Notice the numbers in the square bracket to the
# left of the output. These are the positions of each element.
# For example, "A" is in position 1 of LETTERS

# To extract an element in a particular position you
# use square brackets
LETTERS[5] # 5th letter

# Whenever you see the name of an object, followed by square brackets
# it means that you are indexing, or navigating around the object

# Vectors are one dimensional so we only need to provide
# one vector to extract information
# To extract LETTERS 5 to 8
LETTERS[5:8]

# To extract LETTERS 5, 7, and 10
LETTERS[c(5, 7, 10)]

# ---- Slides: Packages ----

# ---- Data Frames ----
# There are many different ways to import data into R
# The most common way that data is used in R is
# in a data frame with each observation in rows
# and each variable as a column (vector)

# Throughout this course you'll learn several of the
# most common ways that you can import data into RStudio

# Here we'll start with the simplest method:
# accessing a dataset that is a built-in
# object in a package

# Install the package called "gapminder"
# It contains information about population, life
# expectancy, and GPD per capita from each country
# as recorded every five years since 1952

# Install package
install.packages("gapminder") # You only need to install the package once!

# Load package
library(gapminder)

# This package comes with the gapminder data set, which can
# be accessed using the function data()
data(gapminder)
# or by creating an object called gapminder, going to the gapminder library
# and finding the built in object caled gapminder
gapminder <- gapminder::gapminder

# Take a look at the data frame
gapminder

# If you look closely, or have some experience using R
# you'll realize that the data is actually in a structure
# called a tibble; for now we'll treat this exactly the same
# as a data frame, and talk about the minor differences
# between this and a data frame later in the course

# ---- Qualiy Checks ----
# When you import data you should always run some
# quick quality checks to ensure that the data has
# imported correctly, and things look the way they
# are supposed to

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

# Because each column is a vector, it must contain one class of data
# To check the class of a column, you can refer to the column
# using $, as you saw in the slides earlier in this module
gapminder$pop  # This says "show me the column called pop in the data frame called gapminder"
class(gapminder$pop)

# To check the structure of each column quickly
str(gapminder)

# This is a good way to quickly check that there are no obvious errors
# in the data; if year was a numeric rather than an integer, you would
# know that there is an accidental decimal point somewhere in the column
# If the life expectancy (lifeExp) was a character vector, you would
# know that somewhere in the column there is a non-numeric character or extra space
# which is causing the entire vector to be coerced into a character vector

# ---- Factors ----
# You will learn more about interacting with factors throughout this course
# Essentially, a factor is a vector that R is intrepreting as
# being categorical. For example, the column called "continent" here is a factor
class(gapminder$continent)

# It contains multiple levels (categories, groups) that R suspects you may want
# to consider in later analyses
# Print the categories (levels, groups) of the continent column
levels(gapminder$continent)
# R will automatically assign an integer value to each level alphabetically
as.numeric(gapminder$continent)

# In the next module, you will learn how to explore and manipulate this data
# using a package called dplyr, and how to create visualizations using
# a package called ggplot2