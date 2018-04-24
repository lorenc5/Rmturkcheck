sum_func <- function(dat){
  # dataset of variables you want summaries on
  dat_min <- apply(dat, 2, min, na.rm=T)
  dat_max <- apply(dat, 2, max, na.rm=T)
  dat_mean <- round(apply(dat, 2, mean, na.rm=T), 4)
  dat_med <- round(apply(dat, 2, median, na.rm=T), 4)
  dat_sd <- round(apply(dat, 2, sd, na.rm=T), 4)
  out <- data.frame(dat_min, dat_max, dat_mean, dat_med, dat_sd)
  colnames(out) <- c("Minimum", "Maximum", "Mean","Median", "Std.Dev")
  return(out)
}
