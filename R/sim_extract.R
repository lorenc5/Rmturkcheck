sim_extract <- function(sim_out, conf_band=F){
  myev <- sim_out$get_qi(qi='ev')
  myev2 <- as.data.frame(matrix(unlist(myev), nrow =1000)) # Default is 1000 sims
  if (conf_band==F){
    mean_out <- apply(myev2, 2, mean)
    mean_out
  } else {
    mean_out <- apply(myev2, 2, mean)
    low_high<- apply(myev2, 2, quantile, probs = c(0.025,0.975))
    mean_out <- c(mean_out, low_high)
    names(mean_out) <- c("ev", "low", "high")
    mean_out
  }
}
