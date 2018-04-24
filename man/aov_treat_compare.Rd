\name{aov_treat_compare}
\alias{aov_treat_compare}
\title{
  ANOVA test across treatment conditions
}
\description{Estimates ANOVA tests returning table

}
\usage{
  aov_treat_compare(dat, var_names, treat_var)
}

\arguments{
  \item{dat}{

  }
  \item{var_names}{

  }
  \item{treat_var}{

  }
}
\value{Table of results

}
\references{aov() function

}
\author{
  Loren Collingwood <loren.collingwood@ucr.edu>
}

\examples{
  data(treat_compare)
  nam <- c("race_r","linked_fate","rr_scale","female","educ_r","democrat","republican","ind_other")
  aov_treat_compare(treat_compare,nam, "treatment")
  }
