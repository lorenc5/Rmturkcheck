\name{drop_it_like_its_bot}
\alias{drop_it_like_its_bot}
\title{
  drop_it_like_its_bot
}
\description{Detects guilty bots in Mturk data based on Qualtrics lat/long coordinates, then drops them returning "clean" dataset

}
\usage{
  drop_it_like_its_bot(lat, long, dat, remove_suspect = "all", more=NULL)
}

\arguments{
  \item{lat}{Column name (character) of survey latitude coordinate, typically generated via Qualtrics
  }
  \item{long}{Column name (character) of survey longitude coordinate, typically generated via Qualtrics
  }
  \item{dat}{data.frame() object, housing survey responses, probably downloaded from Qualtrics
  }
  \item{remove_suspect}{Character string, with options: "all", "keep_first", "more_than". Default = "all". "all" drops any overlap, "keep_first", drops duplicates, "more_than" drops rows with lat/long overlaps greater than the specified criterion}
  \item{more}{Numeric, indicating the number of rows to exclude if greater than a certain number (e.g., Lat 45.44993 appears more than 3 times). Default is NULL; only use if specificying "more_than" to remove_suspect argument.}
}
\value{Returns dataframe() cleaned of all rows fitting "more_than" criterion. Users should then examine lat/long overlaps. Turk IDs, IP addresses, and demographics may all be different, but more than a few responses from the exact same lat/long coordinates seems unlikely. Users can then examine these cases for botness with various validity checks.
}

\author{
  Loren Collingwood <loren.collingwood@ucr.edu>
}

\examples{

###############################
# drop_it_like_it_bot Example #
###############################

# Example Code #
n <- 100
lat <- c( rep("42.999967", n), rnorm(n*4, mean = 44))
long <- c( rep("-80.444825", n), rnorm(n*4, mean = -83))
toy1 <- rnorm(n*5, 20)
toy2 <- rnorm(n*5, 30)
toy3 <- rnorm(n*5, 10)
toy_turk_id <- paste("faux_id:", round(runif(n*5, 0, 2),6), sep="")
df <- data.frame(lat, long, toy1, toy2, toy3, toy_turk_id, stringsAsFactors = F)

toy_bot <- drop_it_like_its_bot(lat = "lat", long = "long", dat = df,
                                remove_suspect = "more_than", more = 3)

}
