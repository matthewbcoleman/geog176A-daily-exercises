#Matthew Coleman
#8-18-2020
#Plot state geometries

library(USAboundaries)
library(tidyverse)
library(sf)

states_raw <- us_states()

states <- states_raw %>% filter(!(name %in% c('Puerto Rico', 'Alaska', 'Hawaii')))

state_ls <- st_cast(states, 'MULTILINESTRING') %>% select(geometry)

plot(state_ls$geometry, col = 'red')
state_ls


states_boundary <- st_union(states$geometry) %>% st_cast('MULTILINESTRING')

plot(states_boundary, col = 'red')
state_boundary
