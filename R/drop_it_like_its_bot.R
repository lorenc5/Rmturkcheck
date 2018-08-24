drop_it_like_its_bot <- function(lat, long, dat, remove_suspect = "all", more=NULL) {
  
  if (is.factor(dat[, lat]) | is.factor(dat[, long]) ){
    stop("Latitude and Longitude should be of class: character or numeric, not factor, didn't you learn nuthin in Stat 101?")
  }
  
  dat$latlong_comb <- paste(dat[, lat],dat[, long], sep="")
  
  if (remove_suspect =="all") {
    
    cat("Remove all rows containing overlapping Lat/Long coordinates\n")
    
    plus <- names(table(dat$latlong_comb)[table(dat$latlong_comb)>1])
    keep <- !dat$latlong_comb %in% plus
    final_bot <- dat[keep,]
    cat(paste("Dataset was n = ", nrow(dat), " now is n = ", nrow(final_bot), sep=""), "\n")
    cat(paste("Bot Estimate: ", round(1 - (nrow(final_bot) / nrow(dat)),4)*100, "%", sep=""), "\n" )
    
  } else if (remove_suspect == "keep_first") {
    
    cat("Remove all duplicate rows after initial row...keeping first row\n")
    keep <- !duplicated(dat$latlong_comb)
    final_bot <- dat[keep,]
    cat(paste("Dataset was n = ", nrow(dat), " now is n = ", nrow(final_bot), sep=""), "\n")
    cat(paste("Bot Estimate: ", round(1 - (nrow(final_bot) / nrow(dat)),4)*100, "%", sep=""), "\n" )    
    
  } else if (remove_suspect == "more_than") {
    
    more <- more
    cat( paste ("Remove rows with than ",more, " overlapping Lat/Long coordinates",sep=""), "\n")
    plus <- names(table(dat$latlong_comb)[table(dat$latlong_comb)>more])
    keep <- !dat$latlong_comb %in% plus
    final_bot <- dat[keep,]
    cat(paste("Dataset was n = ", nrow(dat), " now is n = ", nrow(final_bot),sep=""), "\n")
    cat(paste("Bot Estimate: ", round(1 - (nrow(final_bot) / nrow(dat)),4)*100, "%", sep=""), "\n" )  
    
  }
  return(final_bot)
  
}