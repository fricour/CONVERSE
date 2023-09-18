library(ggplot2)
library(dplyr)

# read bathymetry
data <- read.csv('data/Bathymetry/check_bathy.csv')[,2:3]

# remove land data (no bathymetry)
data <- data[complete.cases(data),]

# bin pixels into groups of bathymetry (between 0-1000 m, 1000-2000 m, ..., > 8000 m)
data <- data %>% mutate(depth_binned=cut(bathy, breaks=c(0, 1000, 2000, 3000, 3500, 4000, 4500, 5000, 8000)))

# compute median FTOC values in those depth bins (+ some other stats)
dlarge <- data %>% group_by(depth_binned) %>% dplyr::summarise(mean_ftoc = mean(x), median_ftoc = median(x), std_ftoc = sd(x), n_points_per_bin = n())

# get pixels (and especially ocean pixels without FTOC values)
add_data <- read.csv('data/Bathymetry/fill_missing_pixels.csv')[,2:3]

for(i in 1:nrow(add_data)){
  if(!is.na(add_data$mask_FTOC[i])){ # ocean pixel, add bathymetry to it
    depth <- add_data$bathy[i]
    if(is.na(depth)){ # land pixel
      add_data$mask_FTOC[i] <- 0
    }else if(depth<1000){ # add median FTOC depending on the pixel's bathymetry
      add_data$mask_FTOC[i] <- dlarge$median_ftoc[1]
    }else if(depth < 2000){
      add_data$mask_FTOC[i] <- dlarge$median_ftoc[1]
    }else if(depth < 3000){
      add_data$mask_FTOC[i] <- dlarge$median_ftoc[2]
    }else if(depth < 3500){
      add_data$mask_FTOC[i] <- dlarge$median_ftoc[3]
    }else if(depth < 4000){
      add_data$mask_FTOC[i] <- dlarge$median_ftoc[4]
    }else if(depth < 4500){
      add_data$mask_FTOC[i] <- dlarge$median_ftoc[5]
    }else if(depth < 5000){
      add_data$mask_FTOC[i] <- dlarge$median_ftoc[6]
    }else{
      add_data$mask_FTOC[i] <- dlarge$median_ftoc[7]
    }
  }
}

# save data
write.csv(add_data, file='data/Bathymetry/missing_pixels_filled.csv', row.names = F)

