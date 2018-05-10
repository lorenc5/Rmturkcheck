\name{clearn_turk_id}
\alias{clearn_turk_id}
\title{
  Clean MTurk ID
}
\description{Cleans MTurk Unique ID for easier merging between waves

}
\usage{
  clearn_turk_id(mtid)
}

\arguments{
  \item{mtid}{Character vector of MTurk unique identifiers
  }

}
\value{Character vector of cleaned MTurk unique identifiers, stripping whitespace, converting case to lower, converting blanks to NA. Prints vector description.

}
\references{stringr

}
\author{
  Loren Collingwood <loren.collingwood@ucr.edu>
}

\examples{

# GENERATE RANDOM IDS #
letter_rand <- function(n=100) {
  a <- do.call(paste0, replicate(4, sample(LETTERS, n, TRUE), FALSE));
  paste0(a, sprintf("%04d", sample(9999, n, TRUE)), sample(LETTERS, n, TRUE));
}
  
# EXECUTE FUNCTION #
mtid_toy_vec <- letter_rand()

# MANIPULATE A FEW FOR PEDAGOGICAL PURPOSES (DID I SPELL THAT REAL GOOD?)
mtid_toy_vec[100] <- paste("", mtid_toy_vec[100], " ")
mtid_toy_vec[99] <- ""
mtid_toy_vec[98] <- paste("28n0", mtid_toy_vec[98], sep="_")

#EXECUTE FUNCTION #
mtid_r <- clean_turk_id(mtid_toy_vec)
head(mtid_r)
}
