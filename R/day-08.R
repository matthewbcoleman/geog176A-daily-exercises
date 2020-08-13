#Matthew Coleman
#8-13-2020
#Plot the rolling average and new cases of covid for Florida

library(tidyverse)
library(ggthemes)
library(zoo)

#Plot of new cases and 7-day Moving average
covid <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")

florida_covid <- covid %>% filter(state == "Florida") %>% group_by(date) %>%
  summarise(total_cases = sum(cases)) %>% mutate(new_cases = c(NA, diff(total_cases)),
                                                 rolling_mean= rollmean(new_cases, 7, fill=NA, align = 'right'))


g <- florida_covid %>%
  ggplot(aes(x = date) ) +
  geom_col(aes(y = new_cases), col = NA) +
  geom_line(aes(y = rolling_mean)) +
  theme_base() +
  labs(title = "New Reported Cases by Day in Florida",
       x = 'Date', y = 'Cases') +
  theme(plot.title = element_text(size=14))

g

ggsave('img/rollingaverage.jpg', g)
