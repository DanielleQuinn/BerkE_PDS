# ---- Module 4 ----

# ---- Preparing the workspace ----
library(dplyr) # Reshaping & manipulating data
library(tidyr) # More reshaping & manipulating data

# Import data as a .csv from your current working directory (folder)
US_data <- read.csv("US_data.csv")
# A .csv is a "comma separate values" format; each piece of information is
# separated by a comma. This is an example of a universal file format that 
# can be interpreted without requiring any proprietary software.

# The "current working directory" is the folder on your computer that
# R will interact with; if you ask it to import data or save a file, it
# is the folder that R will use to look for or store information

# To find your current working directory use
getwd()

# To update your current working directory use setwd() with
# the approproate path to the folder
setwd("C:/Users/Danielle/Desktop")

# Explore the data
head(US_data, 2)
str(US_data)

# glimpse() : a {dplyr} alternative to str()
# essentially the same information, but more user-friendly and readable
glimpse(US_data)

# You have similar data from other countries but in a different format
# Each individual has a identification number and there are three data frames that contain
# the information for each individual

# ---- nonUS_profession ----
# Contains the identification number and information about their profession
# Import data as a .txt
nonUS_profession <- read.delim("nonUS_profession.txt")
# A .txt file has information separated by a tab and is also called
# "tab delimited".
# By default, the read.delim() function assumes that the separator is a tab

# Explore the data
head(nonUS_profession, 2)
glimpse(nonUS_profession)

# ---- nonUS_demographic ----
# Contains the identification number and demographic data
nonUS_demographics <- read.delim("nonUS_demographics.txt")

# Explore the data
head(nonUS_demographics, 2)
glimpse(nonUS_demographics)

# ---- nonUS_income ----
# Contains the identification number, country, and income in "wide format"
nonUS_income <- read.delim("nonUS_income.txt")
# Notice that each country has its own column and the values in the cells
# represent income. Eventually you will want to convert this to "long format"
# with a column called "id", a column called "country" and a column called "income"

# Explore the data
head(nonUS_income, 2)
glimpse(nonUS_income)

# ---- Combining Data Sets ----
# You need to carefully consider the logical process that will allow you
# to use all of the available data by combining the various pieces into
# a single tidy data frame

# ---- Step One: Combine profession and demographic data ----
# What do these data sets look like?
head(nonUS_profession, 2)
head(nonUS_demographics, 2)

# You can't just stick these data frames together by row because each data
# set has a different order of individuals
# i.e. row 1 of nonUS_profession does not correspond to row 1 of nonUS_demographics

# left_join(x, y) : joins data frames by returning all rows from x and all columns
                  # from x and y based on shared variables
nonUS_data <- left_join(nonUS_profession, nonUS_demographics)
head(nonUS_data, 2)

# There are several "join" functions, each joining two data frames in slightly
# different ways. See https://r4ds.had.co.nz/relational-data.html for more details.

# ---- Step Two: Transform nonUS_income from wide to long ----
# What does this data set look like?
head(nonUS_income, 1)
dim(nonUS_income)

# This data is in "wide" format, where each country has its own column, and each
# individual has their own row. The cells contain information about income
# You need to convert it to "long" format; you want a column called id, a
# column called country, and a column called income

# gather() : collapses multiple columns into key-value pairs
nonUS_income_long <- gather(nonUS_income, key = country, value = income, -id)
# key: what variable name describes what all of the columns to be gathered have in common?
# value: what variable name describes the values contained in the cells?
# Note that you do not want to gather the column called "id" ("id" is not the name
# of a country) so specifiy that the column should be omitted by using -id

# What does the transformed data set look like?
head(nonUS_income_long)
dim(nonUS_income_long)

# ---- Step Three: Remove the rows with income equal to NA ----
# Right now the data has every combination of id and country
# You want to discard these "extra" rows that have been added
# They can be identified by income having a value of NA

# drop_na() :  drop rows containing missing values
nonUS_income_long <- drop_na(nonUS_income_long)

# What does the transformed data set look like?
head(nonUS_income_long)
dim(nonUS_income_long)

# ---- Step Four: Combine nonUS_income_long data with nonUS_data ----
head(nonUS_data, 2)
head(nonUS_income_long)

# Use left_join(), as before
nonUS_data <- left_join(nonUS_data, nonUS_income_long)
head(nonUS_data, 2)

# ---- Step Five: Create country column in US_data ----
# Right now, the US_data doesn't have a column called country
head(US_data, 2)

# If we try to combine US_data and nonUS_data, all of the data from
# the US will have NA, or missing values, in the country column

# You want to create a new column called country and fill it
# in with "United States""

# mutate() : add new variables or modify existing ones
# Create a new column called country, fill it in with a string "United States"
# and update the US_data object
US_data <- US_data %>%
  mutate(country = "United States")

# ---- Step Six: Combine nonUS_data with US_data ----
# Now US_data and nonUS_data are ready to be combined
nrow(US_data) # 29170 rows of US data
nrow(nonUS_data) # 2706 rows of non US data

names(US_data)
names(nonUS_data)

# bind_rows() : bind multiple data frames together by rows
income <- bind_rows(US_data, nonUS_data)
nrow(income) # 31876 rows in total

# The column names need to be the same, but can be in a different order;
# bind_rows() will line the columns up appropriately.
# If one data frame has an extra column, it will be filled in with NA
# in the rows from the other data frame

# ---- Step Seven: Drop id column ----
# You no longer need identification numbers for each individual
income <- income %>%
  select(-id)

# ---- Step Eight: Correct the spelling of the column "governement_work" ----
# You can see that one of the variable names is spelled incorrectly
names(income)

# rename() : modify column names in a data frame using the format new_name = old_name
income <- income %>%
  rename(government_work = governement_work)

# ---- Step Nine: Change . to spaces in country names ----
# You can see that there are country names that contain .
unique(income$country)

# gsub() : find and replace characters
test <- "This is a test - can you find it?"
test
gsub(pattern = "find", replacement = "replace", test)

# Because "." is a reserved symbol, you need to specify that you are actually
# looking for "." by adding two backslashes
income <- income %>%
  mutate(country = gsub(pattern = "\\.", replacement = " ", country))
# For more information about why you need th backslashes, see
# https://r4ds.had.co.nz/strings.html#basic-matches

# ---- Step Ten: Convert character columns to factors ----
# You can see that while cleaning the data, we've ended up with some
# columns that are characters; you will want to convert these to factors
glimpse(income)

# You can do one at a time
income <- income %>%
  mutate(government_work = as.factor(government_work))

# Or do all of them at once
# mutate_if() : apply a transformation to a variable if a condition is met
income <- income %>%
  mutate_if(is.character, as.factor)

glimpse(income)

# ---- Other Functions ----
# sample_n() : select random rows from a data frame
set.seed(123) # ensures reproducibility by specifiying a set of random numbers
income %>%
  sample_n(1)

# arrange() : order the rows of a data frame by a specified variable
income %>%
  arrange(age, hours_per_week) %>%
  head()

income %>%
  arrange(desc(age)) %>%
  head()

# pull() : extract the values of a column as a vector
income %>%
  filter(age > 88) %>%
  pull(gender)

income %>%
  filter(age == 88) %>%
  select(gender) %>%
  str()

# recode() : replace values in a column with new values
levels(income$relationship)

income %>%
  mutate(relationship = recode(relationship, "Not in family" = "Unrelated")) %>%
  select(relationship)

# ---- Export the Data ----
# Export the data as a .csv ("comma separated values")
write.csv(income, "income.csv", row.names = FALSE)

# Export the data as a .txt ("tab delimited values")
write.table(income, "income.txt", row.names = FALSE, sep = "\t")