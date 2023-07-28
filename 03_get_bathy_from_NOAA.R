# Download bathymetry data from NOAA

library(readr)
library(marmap)
library(tidyverse)

# Download from server
dir.create("data/Bathymetry", showWarnings=T, recursive=T)
bathy_grid <- getNOAA.bathy(lon1=-180,lon2=180,lat1=-90,lat2=90, resolution=60, keep = TRUE, path = 'data/Bathymetry/')



