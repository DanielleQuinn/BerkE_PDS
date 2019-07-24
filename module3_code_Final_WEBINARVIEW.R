# ---- Slides: Data Visualization ----

# ---- Preparing the workspace ----
library(gapminder) # Accessing the data
library(ggplot2) # Data visualization
library(dplyr) # Data manipulation

# Access the data
gapminder <- gapminder::gapminder
head(gapminder)

# ---- The ggplot2 package ----
# A common misunderstanding: the name of the *package* is ggplot2
# but the name of the function used is ggplot()

# The ggplot() function initializes a gpplot object
ggplot()

# Specify the data set
ggplot(gapminder)

# Specify the coordinate system
ggplot(gapminder, aes(x = year, y = pop))

# Define the geom as a new layer
# To create a scatterplot, use the function geom_point()
ggplot(gapminder, aes(x = year, y = pop)) +  
  geom_point()

# ---- Alternative syntax ----
# ggplot() provides the default for all layers of the plot

# Alternatively, specify within the geom function being used
ggplot(gapminder) +
  geom_point(aes(x = year, y = pop))

# ---- Adding dimensions: color ----
# Point color based on continent
ggplot(gapminder) +
  geom_point(aes(x = year, y = pop, col = continent))

# Set point colour to "blue"
ggplot(gapminder) +
  geom_point(aes(x = year, y = pop, col = "blue")) # doesn't work!

# Why do you think this happens?



# Solution: specify col *independent* of the aes() function
ggplot(gapminder) + 
  geom_point(aes(x = year, y = pop), col = "blue")

# ---- Boxplots ----
# A categorical (factor) column on the x axis
ggplot(gapminder) +
  geom_boxplot(aes(x = continent, y = lifeExp))

# A numeric column on the x axis
ggplot(gapminder) +
  geom_boxplot(aes(x = year, y = lifeExp))

# Why do you think this happens?
glimpse(gapminder)



# Solution: treat year as a factor
ggplot(gapminder) +
  geom_boxplot(aes(x = as.factor(year), y = lifeExp))

# ---- Line plots ----
ggplot(gapminder) + 
  geom_line(aes(x = year, y = lifeExp)) # not useful!

# A different line for each country
ggplot(gapminder) + 
  geom_line(aes(x = year, y = lifeExp, group = country))

# Color based on continent
ggplot(gapminder) + 
  geom_line(aes(x = year, y = lifeExp,
                group = country, col = continent))

# ---- Histograms ----
ggplot(gapminder) +
  geom_histogram(aes(x = lifeExp))

# Fill based on continent
ggplot(gapminder) +
  geom_histogram(aes(x = lifeExp, fill = continent))

# ---- ggplot objects ----
# ggplot plots can be stored in an object!
figure1 <- ggplot(gapminder) +
  geom_line(aes(x = year, y = pop,
                col = continent, group = country))
figure1

# Add layers directly to the object
figure1 + 
  geom_point(aes(x = year, y = pop))

# ---- Axes labels ----
# Update the axes labels
figure1 +
  xlab("Year") +
  ylab("Population")

# ---- Themes ----
# Black and white theme
figure1 + 
  theme_bw()

# Classic theme
figure1 + 
  theme_classic()

figure1 +
  theme_dark()

# ---- Facetting Plots ----
# Each continent gets its own panel
figure1 +
  facet_wrap(~continent)

# Set the y axis limits independently
figure1 +
  facet_wrap(~continent, scales = "free_y")

figure1

figure1 <- figure1 +
  facet_wrap(~continent, scales = "free_y")

# ---- Saving plots ----
# Export
ggsave("figure1.pdf", figure1)

# Cookbook for R ggplot2



# ---- Slides: Introduction to {dplyr} ----

# ---- Selecting columns ----
# select() : view particlar columns

# View the country, year, and pop columns
select(gapminder, country, year, pop)

# Use - to indicate columns that you want to omit
# View all columns except lifeExp, gdpPercap, and continent
select(gapminder, -lifeExp, -gdpPercap, -continent)

# ---- Filtering rows ----
# filter() : view particlar rows based on a logical statement
3 == 4
4 > 2

# Only view rows where the year is equal to 1957
filter(gapminder, year == 1957)

# Only view rows where the year is equal to 1957 and
# the country is equal to France
filter(gapminder, year == 1957, country == "France")

# Only view rows where the year is greater than 2000 and
# the country is one of Canada, Ireland, or France
subset1 <- filter(gapminder, year > 2000,
                    country %in% c("Canada", "Ireland", "France"))
subset1

# ---- Pipes ----
# Information is put into a pipe. When it "comes out" the other
# side, a function is applied to it

# Find the square root of the square root of 81
# Option 1: Nested functions
sqrt(sqrt(81))

# Option 2: Pipes %>%
81 %>% # step one: 81
  sqrt() %>%  # step two: sqrt
  sqrt() # step three: sqrt
  
81 %>% 
  sqrt() %>% 
  sqrt()

# View the year and country columns of gapminder
select(gapminder, year, country)

gapminder %>%
  select(year, country)


# More complex task
# Step One: Start with the gapminder data frame
# Step Two: Filter where year is greater than 2000 and 
          # country is France
# Step Three: Select only country, year, and lifeExp columns
gapminder %>%
  filter(year > 2000, country == "France") %>%
  select(country, year, lifeExp)

# This is a shell pipe   |
# This is a R pipe   %>%

# ---- Grouping and summarizing data ----
# group_by() : groups data based on a given variable
# summarise() : generates summary information for each group

# What is the average gdpPercap for each continent?
gapminder %>%
  group_by(continent) %>%
  summarise(mean(gdpPercap))

# Give better column names in the results
gapminder %>%
  group_by(continent) %>%
  summarise(average_gdp = mean(gdpPercap))


# Create a dataframe that includes the minimum, mean, and maximum
# population of each continent, by year, since 1990
df1 <- gapminder %>%
  filter(year > 1990) %>%
  group_by(continent, year) %>%
  summarise(minimum_pop = min(pop),
            maximum_pop = max(pop),
            mean_pop = mean(pop))
df1

# Visualize these results
ggplot(df1) +
  geom_point(aes(x = year, y = mean_pop)) +
  geom_line(aes(x = year, y = mean_pop, group = continent)) +
  geom_line(aes(x = year, y = minimum_pop, group = continent),
            col = "red", linetype = "dashed") +
  geom_line(aes(x = year, y = maximum_pop, group = continent),
            col = "blue", linetype = "dashed") +
  facet_wrap(~continent, scales = "free_y", ncol = 2) +
  theme_bw(18) + ylab("Population") + xlab("Year")
