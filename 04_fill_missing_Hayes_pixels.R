library(ggplot2)
library(dplyr)

data <- read.csv('data/Bathymetry/check_bathy.csv')[,2:3]
data <- data[complete.cases(data),]

data <- data %>% mutate(depth_binned=cut(bathy, breaks=c(0, 1000, 2000, 3000, 3500, 4000, 4500, 5000, 8000)))
dlarge <- data %>% group_by(depth_binned) %>% dplyr::summarise(mean_ftoc = mean(x), median_ftoc = median(x), std_ftoc = sd(x), n_points_per_bin = n())

add_data <- read.csv('data/Bathymetry/fill_missing_pixels.csv')[,2:3]

for(i in 1:nrow(add_data)){
  if(!is.na(add_data$mask_FTOC[i])){
    depth <- add_data$bathy[i]
    if(is.na(depth)){
      add_data$mask_FTOC[i] <- 0
    }else if(depth<1000){
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

write.csv(add_data, file='data/Bathymetry/missing_pixels_filled.csv', row.names = F)

