\name{t_out}
\alias{t_out}
\title{
  t_out, t-test comparisons
}
\description{Single t-test comparison producing table

}
\usage{
  t_out(test)
}

\arguments{
  \item{test}{t.test() output between two numeric vectors, in form of x,y.
  }

}
\value{Table of values: mean 1, mean 2, t-statistic, p-value

}

\references{t.test() function

}
\author{
  Loren Collingwood <loren.collingwood@ucr.edu>
}

\examples{
data(w1)
data(w2)
ttest <- t.test(w1$educ_r,w2$educ_r)
t_out(ttest)
}
