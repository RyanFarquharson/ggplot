library(tidyverse)

gapminder <- read_csv("data/gapminder-FiveYearData.csv")

gapminder

#building a plot in ggplot

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))

# need data, aesthetic, then give it a geometry

ggplot(data = gapminder, 
       mapping = aes(x = gdpPercap, y = lifeExp)) + geom_point()

#challenge: how life expectance has changed over time

ggplot(data = gapminder, 
       mapping = aes(x = year, y = lifeExp)) + geom_point()

# need to group because it thinks year is continuous

ggplot(data = gapminder, 
       mapping = aes(x = year, y = lifeExp, group = year)) + geom_boxplot()

# bring year in as.factor, then don't need to group

ggplot(data = gapminder, 
       mapping = aes(x = as.factor(year), y = lifeExp)) + geom_boxplot()


ggplot(data = gapminder, 
       mapping = aes(x = year, y = lifeExp, colour = continent)) + geom_point()

ggplot(data = gapminder, 
       mapping = aes(x = year, y = lifeExp, group = country, colour = continent)) + 
  geom_line()

# show points in a line plot.  ggplot has layers

ggplot(data = gapminder, 
       mapping = aes(x = year, y = lifeExp, group = country, colour = continent)) +
  geom_line() +
  geom_point()

# aesthetics are inheretted from above.  can move 

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, group = country)) +
  geom_point() +
  geom_line(aes(colour = continent))
  
ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, group = country)) +
  geom_point(colour = "blue") + #maps to a colour blue
  geom_line(aes(colour = continent))

# challenge
# map point size to another variable in the data

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, group = country)) +
  geom_point(aes(size = gdpPercap)) +
  geom_line(aes(colour = continent))

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, group = country)) +
  geom_point(aes(size = pop)) +
  geom_line(aes(colour = continent))

#set point size to a value.  don't do in aes.
ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, group = country)) +
  geom_point(size = 0.2) +
  geom_line(aes(colour = continent))

# transform.  change the scale, not the mapping

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, colour = continent)) +
  geom_point() +
  scale_x_log10()

# can do stats on the fly.  e.g. add regression line.  can change colour, size, shape etc inside or out of aes

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, colour = continent)) +
  geom_point(size = 1, shape = "triangle") +
  scale_x_log10() +
  geom_smooth(method = "lm", size = 2)

# panels

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, colour = continent)) +
  geom_line() +
  facet_wrap(~ country) # facet_wrap

# subset data to only have 3 countries

gapminder_s <- gapminder %>% filter(country %in% 
              c("Australia", "United Kingdom", "India", "Zimbabwe"))
gapminder_s

ggplot(data = gapminder_s,
       aes(x = year, y = lifeExp, colour = continent)) +
  geom_line() +
  facet_wrap(~ country) +
  labs( x = "Year", y = "Life Exectancy", 
        title = "Figure 1", 
        colour = "Continent") +
        theme(panel.grid = element_blank(),
              axis.text.x = element_text(angle = 90),
              panel.background = element_rect(fill = "white"))

# pipe in filtered data from gapminder
  
gapminder %>% 
  filter(country %in% c("Australia", "United Kingdom", "India", "Zimbabwe"))
  ggplot(data = gapminder_s,
       aes(x = year, y = lifeExp, colour = continent)) +
  geom_line() +
  facet_wrap(~ country) +
  labs( x = "Year", y = "Life Exectancy", 
        title = "Figure 1", 
        colour = "Continent") +
  theme(panel.grid = element_blank(),
        axis.text.x = element_text(angle = 90),
        panel.background = element_rect(fill = "white"))
  
# challenge 5

gapminder %>% 
  #filter(year %in% "1967") %>% 
  ggplot(aes(x = gdpPercap, fill = continent)) +
  geom_density(alpha = 0.3) + #transparency alpha from 0 - 5
  scale_x_log10() +
  scale_y_continuous(limits = c(0,5)) +
  facet_wrap(~ year) 


  