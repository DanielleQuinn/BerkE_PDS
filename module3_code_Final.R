# ---- Slides: Data Visualization ----

# ---- Preparing the workspace ----
# We always start a script by loading the required packages
library(gapminder) # Accessing the data
library(ggplot2) # Data visualization
library(dplyr) # Data manipulation

# Access the gapminder data set from the gapminder package
gapminder <- gapminder::gapminder

# Look at the first six rows
head(gapminder)

# ---- The ggplot2 package ----
# A common misunderstanding: the name of the *package* is ggplot2
# but the name of the function used is ggplot()

# The ggplot() function initializes a gpplot object
ggplot()
# If you run it alone, with no arguments provided, you don't
# get any any error messages.
# You'll notice a gray square appears in the plot tab in
# the lower right window

# Now we need to specify each of the three components that
# are required for a visualization

# First, we'll specify the data set
ggplot(gapminder)
# Again, this doesn't produce an error but also doesn't
# provide enough information to generate a visualization

# Next, we'll specify the coordinate system as the second
# argument of ggplot()
# Here we will use a special function called aes() to
# define a simple x y coordinate system, specifying that
# we want the variable year on the x axis and the variable
# population (pop) on the y axis
# You can think of the aes function as an assistant;
# the variables that you are providing can be found in the
# gapminder dataset, and so you need the "assistant" to go
# retrieve that information from the dataset
# Any coordinate system that relies on a variable in the data frame needs to be
# given to aes for handling
ggplot(gapminder, aes(x = year, y = pop))
# Again, this doesn't produce an error, and now we can see that
# the coordinate system has been defined as apparent in the plot;
# the range of each axis has been determined based on the data available

# The last component we need to define is the
# geom, which is how we want the information visually represented
# This component is defined as a new layer of the plot,
# and can be added using the + symbol following the ggplot()
# To create a scatterplot, use the function geom_point()
ggplot(gapminder, aes(x = year, y = pop)) +
  geom_point()

# Although this is a single line of code, you can hit Enter following
# the + to move the new layer geom_point() to a new line. This can 
# improve code readability

# ---- Alternative syntax ----
# Anything in ggplot() provides the default for all layers of the plot
# Above, we specified both the data set and the coordinate system
# in ggplot()

# Alternatively, we can specify the coordinate system to be specific
# to the geom function being used
ggplot(gapminder) +
  geom_point(aes(x = year, y = pop))

# This code does the very same thing as what we saw earlier;
# there are times when one approach is more efficient than
# the other but the vast majority of the time your personal
# preference will be fine. In this course we will tend to
# use the second method, specifying the coordinates in the geom
# function, and you will be introduced to some instances where
# this allows greater flexibility for creating plots.

# ---- Adding dimensions: color ----
# Let's say that you want the colour of each point to be 
# based on the continent that the point corresponds to.
# We will use the argument 'col' to indicate that we want to
# add a dimension related to color
ggplot(gapminder) +
  geom_point(aes(x = year, y = pop, col = continent))
# Because the information about continent is found in
# the gapminder dataset, we need to give this argument
# to our assistant, the aes function, to go find it in
# the data frame

# What if we simply wanted all of our points to be blue?
# First, ggplot has a huge library of colours, which can
# be referenced as a string (or word)
ggplot(gapminder) +
  geom_point(aes(x = year, y = pop, col = "blue"))
# What happened here? The points are pink, but the legend indicates
# the the colour of the point is based on the variable called blue
# This is because we have given a piece of information to our assistant
# aes() that has nothing to do with the dataset. It has gone to
# the dataset and tried to find something called "blue". When it couldn't
# find anything, it makes assumptions about what we were actually trying to do

# To fix this, we are going to specify that we want the color to 
# be "blue" *independent* of the aes() function
ggplot(gapminder) + 
  geom_point(aes(x = year, y = pop), col = "blue")

# ---- Adding dimensions: shape ----
# Let's make the shape of our points triangles
# Add the argument shape
ggplot(gapminder) + 
  geom_point(aes(x = year, y = pop), shape = "triangle")

# ---- Adding dimensions: size ----
# Let's make the size of the points be based on
# GDP per capita (gdpPercap)
ggplot(gapminder) +
  geom_point(aes(x = year, y = pop, size = gdpPercap))
# Notice that we've moved the size argument
# *inside* of the aes() function because the information
# needed can be found in the dataset, so we need to send the
# assistant to find it

# There are lots of other options to explore!

# ---- Boxplots ----
# So far we've only looked at scatterplots but there
# are many other ways to visually represent data

# The y axis should be numeric

# If the x axis is a factor (categorical)...
ggplot(gapminder) +
  geom_boxplot(aes(x = continent, y = lifeExp))
# a separate boxplot will be created for each level of the factor

# If you try to use a numeric vector on the x axis...
ggplot(gapminder) +
  geom_boxplot(aes(x = year, y = lifeExp))
# It won't work because it doesn't know how to
# split numbers into separate boxplots; you can specify
# that you want to treat year as a factor
ggplot(gapminder) +
  geom_boxplot(aes(x = as.factor(year), y = lifeExp))

# ---- Line plots ----
# The group option is also helpful when you
# are trying to plot multiple lines
ggplot(gapminder) + 
  geom_line(aes(x = year, y = lifeExp))
# A line will automaticlaly try to connect points in the
# order they appear along the x axis; here we have multiple
# y values for each value of x so it doesn't work
# Instead, let's create a different line for each country
ggplot(gapminder) + 
  geom_line(aes(x = year, y = lifeExp, group = country))

# Here, we could also say that we want the color of each line
# to represent continent
ggplot(gapminder) + 
  geom_line(aes(x = year, y = lifeExp, group = country, col = continent))

# ---- Histograms ----
# Supply a numeric column for the x axis
ggplot(gapminder) +
  geom_histogram(aes(x = lifeExp))

# Visualize how it is broken down by continent by
# specifying how the bars should be filled
ggplot(gapminder) +
  geom_histogram(aes(x = lifeExp, fill = continent))

# Now that you understand the basic structure of ggplot()
# it's time to start polishing the final products

# ---- ggplot objects ----
# One useful feature of ggplot plots is that
# they can be stored in an object!
# Use the assignment operator; remember that this won't
# actually show you the plot, only store it in the object
figure1 <- ggplot(gapminder) +
  geom_line(aes(x = year, y = pop, col = continent, group = country))

# Call on the object to see the plot
figure1

# We can add layers directly to the object rather than
# typing out the code again
figure1 + 
  geom_point(aes(x = year, y = pop))

# ---- Axes labels ----
# It is fairly simple to update the axes labels by adding
# layers using xlab() and ylab() functions
figure1 +
  xlab("Year") +
  ylab("Population")

# ---- Themes ----
# There are a variety of different themes that you
# can be used to polish the aesthetics of the plot, like
# the background color and grid lines

# Black and white theme
# One of the simplest is theme_bw()
figure1 + 
  theme_bw()

# Classic theme
figure1 + 
  theme_classic()

# Minimal theme
figure1 + 
  theme_minimal()

# ---- Customizing Scales ----
# What if we wanted to specify the five colors that are being used?
# There are a series of functions that start with scale_ that
# are used to customize the scales used for color, shape, size, etc.

# Here we'll use scale_color_manual to manually select the five colors
# that we want to use to represent the five continents included
# in the visulization as a vector
# There is a huge number of options and the function also
# accept hexidecimal values
figure1 <- figure1 +
  theme_bw() +
  scale_color_manual(values = c("black", "green", "red", "darkorchid4", "#228B22"))
figure1

# ---- Facetting Plots ----
# What if we wanted to use this plot, but separate each continent
# into its own panel?
figure1 +
  facet_wrap(~continent)

# You can see that the limits of the y axis is determined by the
# overall range of the data. We can change this so that the
# y axis of each panel is automatically determined individually
figure1 <- figure1 +
  facet_wrap(~continent, scales = "free_y")
figure1

# ---- Saving plots ----
# Use ggsave() to export the visualization
# There are a variety of arguments you can use to specify the file type,
# resolution, size, and more
ggsave("figure1.pdf", figure1)

# ---- Resources ----
# RStudio > Help > Cheatsheets > Data visualization with ggplot2
# Cookbook for R ggplot2

# ---- Slides: Introduction to {dplyr} ----

# ---- Selecting columns ----
# select() : view particlar columns
# It requires the name of the data frame object being used,
# and the names of the columns within that data set that
# you want to view

# Only view the country, year, and pop columns
select(gapminder, country, year, pop)

# Use - to indicate columns that you want to omit
select(gapminder, -lifeExp, -gdpPercap, -continent)

# ---- Filtering rows ----
# filter() : view particlar rows based on a logical statement
# It requires the  name of the data frame object being used,
# and a logical statement. This function will keep the
# rows where the logical statement is TRUE.

# Only view rows where the year is equal to 1957
filter(gapminder, year == 1957)

# You can apply multiple logical statements using &
# Only view rows where the year is equal to 1957 and
# the country is equal to France
filter(gapminder, year == 1957,  country == "France")

# Only view rows where the year is greater than 2000 and
# the country is one of Canada, Ireland, and France
# Put these results in a new data frame called subset1
subset1 <- filter(gapminder, year > 2000,
                  country %in% c("Canada", "Ireland", "France"))
subset1

# ---- Pipes ----
# The power of dplyr is that you can link these functions
# together to create a reproducible workflow using pipes (%>%)

# Information is put into a pipe. When it "comes out" the other
# side, a function is applied to it

# Let's start with a simple example. In the last module we
# talked about nesting functions. To find the square root of the
# square root of 81
sqrt(sqrt(81))

# Nested functions are powerful but can be tricky to read. Pipes
# give us an alternative syntax

81 %>% # Step One: Start with the value 81
  sqrt() %>% # Step Two: Find the square root
  sqrt() # Step Three: Find the square root of the solution from step two

# To view the year and country columns of gapminder
gapminder %>% # Step One: Start with the gapminder data frame
  select(year, country) # Step Two: Select the year and country columns

# Try a more complex task
# Step One: Start with the gapminder data frame
# Step Two: Filter where year is greater than 2000 and country is France
# Step Three: Select only country, year, and lifeExp columns
gapminder %>%
  filter(year > 2000, country == "France") %>%
  select(country, year, lifeExp)

# If you are familiar with Unix Shell:
  # This is a shell pipe:   |
  # This is a R pipe:   %>%

# ---- Grouping and summarizing data ----
# A common task is to create groups of data and
# find summary statistics, like mean, of each group

# group_by() : groups data based on a given variable
# summarise() : generates summary information for each group
# What is the average gdpPercap for each continent?
gapminder %>%
  group_by(continent) %>%
  summarise(mean(gdpPercap))

# It can be helpful to give the resulting table better column names
gapminder %>%
  group_by(continent) %>%
  summarise(average_gdp = mean(gdpPercap))

# These simple functions and pipes can be used to
# accomplish increasingly complex tasks

# Create a dataframe that includes the minimum, mean, and maximum
# population of each continent, by year, since 1990
df1 <- gapminder %>%
  filter(year > 1990) %>%
  group_by(continent, year) %>%
  summarise(minimum_pop = min(pop),
            maximum_pop = max(pop),
            mean_pop = mean(pop))
df1

# You can use these customized data frames to visualize
# specific aspects of the data
# Visualize these results

# Use the df1 object
ggplot(df1) + 
  # Scatterplot of mean_pop and year
  geom_point(aes(x = year, y = mean_pop)) + 
  # Line plot of mean_pop and year, by continent
  geom_line(aes(x = year, y = mean_pop, group = continent)) +
  # Line plot of minimum_pop and year as a red dashed line
  geom_line(aes(x = year, y = minimum_pop, group = continent), col = "red", linetype = "dashed") +
  # Line plot of maximum_pop and year as a blue dashed line
  geom_line(aes(x = year, y = maximum_pop, group = continent), col = "blue", linetype = "dashed") +
  # facetted by continent, with free y axis limits
  facet_wrap(~continent, scales = "free_y") +
  # Black and white theme
  theme_bw() + 
  # Updated y and x axis labels
  ylab("Population") + xlab("Year")

# You'll be learning how to apply more dplyr functions throughout this course