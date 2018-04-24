aov_treat_compare <- function (dat, var_names, treat_var){

  # dat = dataframe, the final survey dataframe
  # var_names = character vector of demographic variables to compare across treatment condition
  # treat_var = character vector (1) name of treatment indicator

  # Conduct ANOVA test and put into matrix for table output #
  aov_mat <- matrix(NA, nrow=length(var_names), ncol=2)
  for (i in 1:length(var_names)){
    aov_mat[i,] <- unlist ( summary ( aov(formula (
      paste (var_names[i], "~ as.factor(", treat_var, ")", sep="" )), data = dat )))[c(7,9)]
  }
  # Label Datasets #
  colnames(aov_mat) <- c("F-Value", "P-Value")
  rownames(aov_mat) <- var_names
  aov_mat <- round(aov_mat, 4)
  return (aov_mat)
}
