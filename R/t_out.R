t_out <- function(test) {
  # Single t-test table creation line #
  # test = htest class object, result of t.test() X, Y operation
  val1 <- test$estimate[1]
  val2 <- test$estimate[2]
  diff <- abs(val1 - val2)
  stat <- test$statistic
  p.val <- test$p.value
  vec_out <- round(c(val1, val2, diff, stat, p.val),4)
  names(vec_out) <- c("W1_Mean", "W2_Mean", "Abs_Diff", "T_Stat", "P_Value")
  return(vec_out)

}
