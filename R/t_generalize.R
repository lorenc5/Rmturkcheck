t_generalize <- function(w1, w2, cnames1, cnames2) {
  # Arguments #
  # w1 = wave1 dataset
  # w2 = wave2 dataset, which is w1 and w2 merged, actually.
  # cnames1; cnames2 = character vector of column names; must be same name

  # Error Handling #
  if( !identical(cnames1, cnames2) ) {
    stop("Error: cnames1 and cnames2 are not identical. Make them identical real good")
  }

  # Print Dimensions #
  cat("Wave 1 Dimensions:\n")
  print(dim(w1))
  cat("Wave 2 Dimensions:\n")
  print(dim(w2))
  cat("\n")

  # Select Columns
  col_select1 <- colnames(w1) %in% cnames1
  col_select2 <- colnames(w2) %in% cnames2

  # select appropriate columns
  w1 <- w1[,col_select1]
  w2 <- w2[,col_select2]

  w1 <- w1[, cnames1]
  w2 <- w2[, cnames2]
  
  # Create matrix holder
  ttest_collect <- matrix(NA, nrow=ncol(w1), ncol=5) # nrow=length of t_out() result

  # Loop over columns and fill down ttest_collect rows
  for (i in 1:ncol(w1)){
    ttest_collect[i,] <- t_out(t.test(w1[,i], w2[,i]))
  }

  # Label columns and rows
  colnames(ttest_collect) <- c("W1_Mean", "W2_Mean", "Abs_Diff", "T_Stat", "P_Value")
  rownames(ttest_collect) <- cnames1
  # Return Matrix
  return(ttest_collect)

}
