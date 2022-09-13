library(ggplot2)
library(dplyr)

data <- read.csv('./sediment/check_bathy.csv')[,2:3]
data <- data[complete.cases(data),]

# data <- data %>% mutate(depth_binned_large=cut(bathy, breaks=c(0, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000, 7500, 8000)),
#                        depth_binned=cut(bathy, breaks=c(0, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000)), include.lowest=TRUE)
#
# dlarge <- data %>% group_by(depth_binned) %>% dplyr::summarise(mean_ftoc = mean(x), median_ftoc = median(x), std_ftoc = sd(x), n_points_per_bin = n())
# data %>% group_by(depth_binned_large) %>% dplyr::summarise(mean_ftoc = mean(x), median_ftoc = median(x), std_ftoc = sd(x), n_points_per_bin = n())

data <- data %>% mutate(depth_binned=cut(bathy, breaks=c(0, 1000, 2000, 3000, 3500, 4000, 4500, 5000, 8000)))
dlarge <- data %>% group_by(depth_binned) %>% dplyr::summarise(mean_ftoc = mean(x), median_ftoc = median(x), std_ftoc = sd(x), n_points_per_bin = n())

add_data <- read.csv('./sediment/fill_missing_pixels.csv')[,2:3]

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

write.csv(add_data, file='./sediment/missing_pixels_filled.csv', row.names = F)

# data <- read.csv('./sediment/check_sed_depth.csv')[,2:4]
# data <- data[complete.cases(data),]
#
# data <- data %>%mutate(depth_binned=cut(zmax, breaks=c(0, 1000, 1500, 2000, 3000, 4000, 5000, 6000, 7000),
#                                  include.lowest=TRUE))
#
# data %>% group_by(depth_binned) %>% dplyr::summarise(mean_ftoc = mean(x), median_ftoc = median(x), std_ftoc = sd(x), n_points_per_bin = n())
#
# ggplot(data, aes(x = x, y = zmax)) + geom_point() + scale_y_reverse()
#
# ggplot(data, aes(x=depth_binned)) + geom_boxplot()
#
# ggplot(data, aes(x = rate, y = log10(x), colour = depth_binned)) + geom_point()
#
# ggplot(data, aes(x = x, y = zmax)) + geom_point() + scale_y_reverse()
# ggplot(data, aes(x = rate, y = zmax)) + geom_point() + scale_y_reverse()
# ggplot(data, aes(x = log10(x), y = log10(zmax))) + geom_point() + scale_y_reverse()
# ggplot(data, aes(x = rate, y = log10(x))) + geom_point()
#
# depth <- log10(data$zmax)
# ftoc <- log10(data$x)
#
# fit <- lm(formula = x ~ zmax, data = data)
# fit
#
# data$x_fitted <- fit$coefficients[1]*data$x + fit$coefficients[2]
#
# ggplot(data, aes(x = log10(x), y = log10(zmax))) + geom_point() + scale_y_reverse() + geom_point(data = data, aes(x = x_fitted, y = log10(zmax)), colour = 'red')
# ggplot(data, aes(x = x, y = zmax)) + geom_point() + scale_y_reverse() + geom_point(data = data, aes(x = 10^x_fitted, y = zmax), colour = 'red')
#
#
# fit2 <- nls(log10(x) ~ a*exp(b*rate)+c, data = data, start = list(a=-1, b = -1, c=1))
# summary(fit2)
#
#
# fit2$m
