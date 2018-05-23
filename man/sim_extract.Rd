\name{sim_extract}
\alias{sim_extract}
\title{
  Simulation Extract
}
\description{Extract simulations from Zelig model

}
\usage{
  sim_extract(sim_out, conf_band=F)
}

\arguments{
  \item{sim_out}{Output from Zelig simulations
  }
  \item{conf_band}{Logical, Default =F
  }

}
\value{Vector output of simulated values

}
\references{Zelig package; Collingwood, Lajevardi, Oskooii (2018)

}
\author{
  Loren Collingwood <loren.collingwood@ucr.edu>
}

\examples{
  # Load Data
data("ban_dummy")

# Create Min/Max
amer_min <- min(ban_dummy$american_identity_r, na.rm=T)
amer_max <- max(ban_dummy$american_identity_r, na.rm=T)

# Model 1: Wave 1 American Identity
summary(model_z <- zelig(ban_w1_r ~ american_identity_r +
                           trump_app_r + muslim_scale, 
                           data = ban_dummy, model="ls"))

# Set low and high american_identity values
x.low <- setx(model_z, american_identity_r = amer_min)
x.high <- setx(model_z, american_identity_r = amer_max)

# Simulate 'Ban' expected values for low american_identity and high american_identity
s.out1 <- Zelig::sim(model_z, x = x.low)
s.out2 <- Zelig::sim(model_z, x = x.high)

# Extract Simulation Expected Values
min_max1 <- c(sim_extract(s.out1), sim_extract(s.out2))

# Model 2: Wave 2 American identity from T1 onto T2 Ban attitudes
summary(model_z <- zelig(ban_w2_r ~ american_identity_r +
                           trump_app_r + muslim_scale, 
                         data = ban_dummy, model="ls"))

# Set low and high american_identity values
x.low <- setx(model_z, american_identity_r = amer_min)
x.high <- setx(model_z, american_identity_r = amer_max)

# Simulate 'Ban' expected values for low american_identity and high american_identity
s.out1 <- Zelig::sim(model_z, x = x.low)
s.out2 <- Zelig::sim(model_z, x = x.high)
min_max2 <- c(sim_extract(s.out1), sim_extract(s.out2))

# Model 3: Ban change T1 to T2
summary(model_z <- zelig(ban_change_r ~ american_identity_r +
                           trump_app_r + muslim_scale, 
                           data = ban_dummy, model="ls"))

# Set low and high american_identity values
x.low <- setx(model_z, american_identity_r = amer_min)
x.high <- setx(model_z, american_identity_r = amer_max)

# Simulate EVs with min-max changes
s.out1 <- Zelig::sim(model_z, x = x.low)
s.out2 <- Zelig::sim(model_z, x = x.high)

# Combine Together 
panel2 <- cbind ( sim_extract(s.out1, conf_band=T), sim_extract(s.out2, conf_band=T))

#################
# Plot Creation #
#################

par(mfrow=c(1,2))

# Panel 1 T1, T2 #

plot(1:2, 
     min_max1, 
     pch=5, 
     bty = "n",
     xaxt="n",
     main="Attitudes on Muslim Ban",
     ylab = "E(Support Muslim Ban)",
     xlab = "Strength of American Identity\n(Measured Wave 1)",
     ylim = c(2,4))
points(1:2, min_max2, pch=6)
lines(1:2, min_max1, lwd=2)
lines(1:2, min_max2, lty=2, lwd=2, col="brown")
axis(1, at=c(1,1.5,2), labels=c("Low", "Mid", "High"))
text(1.7,3.3, "Wave 1")
text(1.9,2.7, "Wave 2")

# Panel 2 Plot -- Difference #

plot(1:2, 
     panel2[1,], 
     pch=17, 
     xaxt="n", 
     bty="n",
     ylim=c(-1, 1),
     main="Change in Attitudes on Muslim Ban\n(Wave 1 to Wave 2)",
     ylab = "E(Muslim Ban Shift)",
     xlab = "Strength of American Identity\n(Measured Wave 1)")
lines(1:2, panel2[1,], lwd=2)
segments(1, panel2[2,1], 1, panel2[3,1])
segments(2, panel2[2,2], 2, panel2[3,2])
axis(1, at=c(1,1.5,2), labels=c("Low", "Mid", "High"))
abline(h=0, col="grey", lty=2, lwd=2)
  
}
