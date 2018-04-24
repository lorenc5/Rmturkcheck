\name{t_generalize}
\alias{t_generalize}
\title{
  T Generalize -- Generalizes x,y t-test to multiple variables
}
\description{T-tests across variables producing table output

}
\usage{
  t_generalize(w1, w2, cnames1, cnames2)
}

\arguments{
  \item{w1}{Dataset 1, probably wave 1

  }
  \item{w2}{Dataset 2, probably wave 2 merged with wave 1 with nrow() wave 2

  }
  \item{cnames1}{Column names (character) of variables to compare across waves

  }
  \item{cnames2}{Column names (character) of variables to compare across waves; needs to be same order as cnames1

  }

}
\value{Table/data.frame of t-statistics with means and p-values across datasets

}
\references{t_out(), t.test()

}
\author{
  Loren Collingwood <loren.collingwood@ucr.edu>
}

\examples{
  # Load example datasets
  data(w1)
  data(w2)

  # Build table
  t_generalize(w1,w2, cnames1=colnames(w2), cnames2=colnames(w2))
  
  # Use xtable if inclined
  xtable(t_generalize(w1,w2, cnames1=colnames(w2), cnames2=colnames(w2)), caption="Loren makes the best jokes", lab="my_tab")
}
