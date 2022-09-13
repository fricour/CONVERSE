#
# Download bathymetry data from NOAA
#
library("readr")
library("marmap")
library("tidyverse")

# Download from server
dir.create("./sediment/Bathymetry", showWarnings=T, recursive=T)
bathy_grid <- getNOAA.bathy(lon1=-180,lon2=180,lat1=-90,lat2=90, resolution=60, keep = TRUE, path = './sediment/Bathymetry/')

# plot(bathy_grid, image=TRUE, deep=-6000, shallow=0, step=1000)
# #
# # Download bathymetry data from NOAA
# #
# library("readr")
# library("marmap")
# library("tidyverse")
# # Download from server
# dir.create("Data/Bathymetry", showWarnings=T, recursive=T)
# a <- getNOAA.bathy(lon1=-180,lon2=180,lat1=90,lat2=-90, resolution=10, keep = TRUE, path = "Data/Bathymetry")
# plot(a, image=TRUE, deep=-6000, shallow=0, step=1000)
# # Read the csv file containing the bathymetry
# NOAA_bathy <- read_delim("Data/Bathymetry/marmap_coord_-180;-90;180;90_res_10.csv", delim=",")
# bathy_data <- NOAA_bathy %>%
#   rename(lon = V1, lat = V2, bathymetry = V3) %>%
#   filter(bathymetry <= 0) %>%
#   mutate(bathymetry = abs(bathymetry))
# # Plot the bathymetry
# ggplot(bathy_data) +
#   geom_raster(aes_string(x="lon", y="lat", fill="bathymetry"))
# ## Create a reference dataframe with the coordinates wanted for the bathymetry values
# #lon_w = c(seq(-179.5, 179.5, by = 1))
# #lat_w = c(seq(-89.5, 89.5, by = 1))
# #coord_wanted = data.frame(lon_w, lat_w)
# # Aggregate the NOAA value according to this grid of lon_w and lat_w
# round_any = function(x, accuracy, f=round){f(x/ accuracy) * accuracy}
# bathy <- bathy_data %>%
#   # Round the lat and lon columns to lat_w and lon_w
#   mutate(lat_round = round_any(lat, accuracy = 1)+0.5,
#          lon_round = round_any(lon, accuracy = 1)+0.5) %>%
#   # Only keep one value per pair of lat_w and lon_w
#   group_by(lon_round, lat_round) %>%
#   summarise(n = n(), bathymetry = mean(bathymetry))
# ggplot(bathy) +
#   geom_raster(aes_string(x="lon_round", y="lat_round", fill="bathymetry"))+
#   ggtitle("Bathymetry 1° grid (Source NOAA)") +
#   ylab ("latitude") + xlab ("longitude")
# save(bathy, file="Data/Bathymetry/2.bathy.Rdata")
# Collapse
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
# Message Laetitia Drago
#





