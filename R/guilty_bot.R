guilty_bot <- function(lat, long, dat, more_than=10) {
  
  if (is.factor(dat[, lat]) | is.factor(dat[, long]) ){
    stop("Latitude and Longitude should be of class: character or numeric, not factor, didn't you learn nuthin in Stat 101?")
  }
  
  dat$latlong_comb <- paste(dat[, lat],dat[, long], sep=", ")
  plus <- names(table(dat$latlong_comb)[table(dat$latlong_comb)>more_than])
  keep <- dat$latlong_comb %in% plus
  final_bot <- dat[keep,]
  cat("Suspect Latitudes. Strongly recommend dropping respondents attached to Lat/Long\n")
  cat("Latitudes, Longitudes\n")
  print(unique(final_bot$latlong_comb))
  cat("Returning dataframe() of all rows qualifying as high bot likelihood\n")
  invisible(final_bot)
}