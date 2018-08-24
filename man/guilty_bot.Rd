\name{guilty_bot}
\alias{guilty_bot}
\title{
  guilty_bot
}
\description{Detects guilty bots in Mturk data based on Qualtrics lat/long coordinates

}
\usage{
  guilty_bot(lat, long, dat, more_than=10)
}

\arguments{
  \item{lat}{Column name (character) of survey latitude coordinate, typically generated via Qualtrics
  }
  \item{long}{Column name (character) of survey longitude coordinate, typically generated via Qualtrics
  }
  \item{dat}{data.frame() object, housing survey responses, probably downloaded from Qualtrics
  }
  \item{more_than}{more_than = numeric number, default = 10}
}
\value{Returns dataframe() object of all rows fitting "more_than" criterion. Users should then examine lat/long overlaps. Turk IDs, IP addresses, and demographics may all be different, but 15 responses from the exact same lat/long coordinates seems unlikely. Users can then examine these cases for botness with various validity checks.

}

\author{
  Loren Collingwood <loren.collingwood@ucr.edu>
}

\examples{

######################
# guilty_bot Example #
######################

n <- 100
lat <- c( rep("42.999967", n), rnorm(n*4, mean = 44))
long <- c( rep("-80.444825", n), rnorm(n*4, mean = -83))
toy1 <- rnorm(n*5, 20)
toy2 <- rnorm(n*5, 30)
toy3 <- rnorm(n*5, 10)
toy_turk_id <- paste("faux_id:", round(runif(n*5, 0, 2),6), sep="")
df <- data.frame(lat, long, toy1, toy2, toy3, toy_turk_id, stringsAsFactors = F)

# Prints out problem coordinates and returns original dataset but only bots
no_soup_for_you <- guilty_bot(lat = "lat", long = "long", dat = df)

# Keep only non-bot data
keep <- !df$toy_turk_id \%in\% no_soup_for_you$toy_turk_id
df_bot_free <- df[keep,]; uniqueN(df_bot_free$toy_turk_id)
head(df_bot_free)

}
