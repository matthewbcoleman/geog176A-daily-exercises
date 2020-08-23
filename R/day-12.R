# Matthew Coleman
# 8-21-2020

library(tidyverse)
library(USAboundaries)
library(sf)
library(ggrepel)

states <- us_states() %>% st_as_sf() %>% filter(!(name %in% c('Puerto Rico', 'Hawaii', 'Alaska')))

tennessee <- states %>% filter(name == 'Tennessee')

touch <- st_filter(states, tennessee, .predicate = st_touches)

g <- ggplot() +
  geom_sf(data = states)+
  geom_sf(data = tennessee) +
  geom_sf(data = touch, fill = 'red', alpha = .5) +
  theme_linedraw() +
  geom_label_repel(data = touch,
                   aes(label = name, geometry = geometry),
                   stat = 'sf_coordinates',
                   size = 3)  +
  labs(x = 'Longitude',
       y = 'Latitude',
       title = "Tennessee's Neighboring States",
       subtitle = 'Map of all states which touch Tennessee')


g

ggsave('img/tennessee.png',g)
