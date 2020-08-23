# Matthew Coleman
# 8-19-2020

library(tidyverse)
library(sf)
library(units)


cities <- read_csv('data/uscities.csv')

cities_spat <- cities %>% st_as_sf(coords = c('lng', 'lat'), crs = 4326)

two_cities <- cities_spat %>% filter((city %in% c('Santa Barbara', 'San Jose')) & (state_name == 'California'))

cities_epsg <- st_transform(two_cities, 5070)

cities_equi <- st_transform(two_cities, '+proj=eqdc +lat_0=40 +lon_0=-96 +lat_1=20 +lat_2=60 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs')

st_distance(two_cities)

st_distance(cities_epsg)

st_distance(cities_equi) %>% set_units("km") %>% drop_units()
