#Matthew Coleman
#8-12-2020
#Making a faceted plot of cumulative cases and deaths by region.

library(tidyverse)
library(ggthemes)
library(sf)


covid <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")

region <- data.frame(state_name = state.name, region = state.region)

covid_region <- covid %>% inner_join(region, by = c('state' = 'state_name'))

covid_tot_region <- covid_region %>% group_by(region, date) %>% summarise(total_cases = sum(cases), total_deaths = sum(deaths))

covid_pivot_region <- covid_tot_region %>% pivot_longer(cols = c('total_cases', 'total_deaths'), names_to = 'type')

type.labs <- c('Total Cases', 'Total Deaths')
names(type.labs) <- c('total_cases', 'total_deaths')

g <- ggplot(data = covid_pivot_region, aes (x = date, y = value, color = region)) +
  geom_line() +
  facet_grid(type~region,
             scales = 'free_y',
             labeller = labeller(type = type.labs)) +
  labs(x = 'Date',
       y = 'Count',
       title = 'COVID-19 Cases and Deaths by Region') +
  theme_gdocs() +
  guides(color = FALSE)

g

ggsave('/Users/matthewcoleman/Documents/GitHub/matthewbcoleman.github.io/img/coviddeathcase.jpg', g)

