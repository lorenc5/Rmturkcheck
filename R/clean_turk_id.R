clean_turk_id <- function(mtid) {
  mtid <- str_to_lower(mtid)
  mtid <- str_trim(mtid)
  mtid <- car::recode(mtid, "''=NA")
  mtid_out <- table (mtid)
  cat("Unique number of elements:\n")
  print(length(unique(mtid)))
  cat("Number of elements:\n")
  print(length(mtid))
  cat("Number of missing IDs:")
  print ( table(is.na(mtid)) )
  cat("Distribution of ID Length:\nSmall numbers (< 5) are missing or possibly errors\n")
  element_count <- as.vector(sapply(mtid,str_length))
  print( table(element_count))
  cat("\n List of duplicate IDs")
  print (mtid_out[mtid_out>1])

  return(mtid)
}
