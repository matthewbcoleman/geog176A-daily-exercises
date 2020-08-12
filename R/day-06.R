# Matthew Coleman
# August 11th, 2020

library(tidyverse)
library(ggthemes)

#First two plots
covid <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")

top_6_states <- covid %>% filter(date==max(date)) %>% group_by(state) %>% summarize(num_cases=sum(cases)) %>% ungroup() %>%
  top_n(6,num_cases) %>% arrange(-num_cases) %>% pull(state)

top_6_states_case <- covid %>% filter(state %in% top_6_states)  %>% group_by(state, date) %>% summarise(cases = max(cases))

g <- ggplot(data = top_6_states_case, aes(x = date, y = cases)) +
          geom_line(aes(color=state)) +
          labs(title = 'COVID-19 Case Count in Top 6 States',
               x = 'Date', y = 'Case Count') +
          facet_wrap(~state) +
          guides(color = FALSE) +
          theme_economist_white()
g

ggsave('/Users/matthewcoleman/Documents/GitHub/matthewbcoleman.github.io/img/statecovidplot.jpg', plot = g)

country_cases <- covid %>% group_by(date) %>% summarise(tot_cases=sum(cases))

c <- ggplot(data=country_cases, aes(x = date, y = tot_cases)) +
      geom_col() +
      labs(title = 'USA COVID-19 Case Count',
           x = 'Date', y = 'Cases') +
      theme_wsj()

c

ggsave('/Users/matthewcoleman/Documents/GitHub/matthewbcoleman.github.io/img/usacasecount.jpg', plot = c)
