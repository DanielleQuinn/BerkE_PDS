# ---- Module 4 ----

# ---- Preparing the workspace ----
library(dplyr)
library(tidyr)

# Import data as a .csv from your current working directory (folder)
US_data <- read.csv("US_data.csv")

# Explore the data
head(US_data, 2)
str(US_data)

# glimpse() : dplyr alternative to str()
glimpse(US_data)

# ---- nonUS_profession ----
# Contains the identification number and information about their profession
# Import data as a .txt
nonUS_profession <- read.delim("nonUS_profession.txt")

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
# Contains the identification number, country, and income in wide format
nonUS_income <- read.delim("nonUS_income.txt")

# Explore the data
head(nonUS_income, 2)
glimpse(nonUS_income)

# ---- Combining Data Sets ----

# ---- Step One: Combine profession and demographic data ----
# What do these data sets look like?
head(nonUS_profession, 2)
head(nonUS_demographics, 2)

# left_join(x, y) : joins data frames by returning all rows from x and all columns
                  # from x and y based on shared variables
nonUS_data <- left_join(nonUS_profession, nonUS_demographics)
head(nonUS_data, 2)

# ---- Step Two: Transform nonUS_income from wide to long ----
# What does this data set look like?
head(nonUS_income, 1)
dim(nonUS_income)

# You want a column called id, a column called country, and a column called income

# gather() : collapses multiple columns into key-value pairs
nonUS_income_long <- gather(nonUS_income, key = country, value = income, -id)

# What does the transformed data set look like?
head(nonUS_income_long)
dim(nonUS_income_long)

nonUS_income_long %>% filter(id == 1)

# ---- Step Three: Remove the rows with income equal to NA ----
# drop_na() :  drop rows containing missing values
nonUS_income_long <- drop_na(nonUS_income_long)

# What does the transformed data set look like?
head(nonUS_income_long)
dim(nonUS_income_long)

nonUS_income_long %>% filter(id == 1)

# ---- Step Four: Combine nonUS_income_long data with nonUS_data ----
head(nonUS_data, 2)
head(nonUS_income_long, 2)

nonUS_data <- left_join(nonUS_data, nonUS_income_long)
head(nonUS_data, 2)

# ----Step Five: Create country column in US_data ----
# Right now, the US_data doesn't have a column called country
head(US_data, 2)

names(US_data)
names(nonUS_data)

# mutate() : add new variables or modify existing ones
US_data <- US_data %>%
  mutate(country = "United States")

# ---- Step Six: Combine nonUS_data with US_data ----
# Now US_data and nonUS_data are ready to be combined
nrow(US_data)
nrow(nonUS_data)

glimpse(US_data)
glimpse(nonUS_data)

names(US_data)
names(nonUS_data)

# bind_rows() : bind multiple data frames together by rows
income <- bind_rows(US_data, nonUS_data)
nrow(income)
names(income)

# ---- Step Seven: Drop id column ----
income <- income %>%
  select(-id)
names(income)

# ---- Step Eight: Correct the spelling of the column "governement_work" ----
# You can see that one of the variable names is spelled incorrectly
names(income)

# rename() : modify column names in a data frame using the format new_name = old_name
income <- income %>%
  rename(government_work = governement_work)

names(income)

# ---- Step Nine: Change . to spaces in country names ----
# You can see that there are country names that contain .
unique(income$country)

# gsub() : find and replace characters
test <- "This is a test - can you find it?"
gsub(pattern = "find", replacement = "replace", test)

income <- income %>%
  mutate(country = gsub(pattern = "\\.", replacement = " ", country))

unique(income$country)

# ---- Step Ten: Convert character columns to factors ----
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

# mutate()
income %>%
  mutate(sqrt_age = sqrt(age)) %>%
  head()

sqrt(income$age)

income %>%
  mutate(sqrt_age = as.character(sqrt(age))) %>%
  glimpse()

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
