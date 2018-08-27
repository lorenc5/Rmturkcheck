
# Rmturkcheck

Rmturkcheck is an R package that facilitates the analysis of Mechanical Turk + Qualtrics single-wave and multi-wave panel studies. This document outlines the general process for implementing and checking data for a two-wave MTurk panel study fielded via the Qualtrics platform.

Many academics and survey practioners combine Mechanical Turk workers (sample) with the Qualtrics survey platform to collect experimental data to test a variety of theories/hypotheses. Rmturkcheck evaluates data arriving in this format. Typically, MTurk samples will include respondent MTurk ids (or you will ask for IDs for two-wave panels), response ids, Internet Protocol (IP) address, and possibly other information. Qualtrics data typically also includes a latitude and longitude coordinate. Thus, when the survey is complete, users download a .csv file including the aforementioned fields plus answers to their survey questions and possible flags for experimental conditions.

However, this process has potential for contamination/error, including (but not limited to):

* 1. The same respondent(s) taking the survey more than once
* 2. Respondents giving fake answers or not actually reading the survey
* 3. Bots automating responses providing essentially fake data.

To address point 1, Rmturkcheck includes a function, clean_turk_id(), which cleans the unique mturk id field and reports the number of identical mturk ids.

Survey analysts and experimentalists typically embed attention checks into their surveys to address point 2. Also...example code:

Recent discoveries suggests that identical respondent latitude/longitude coordinates may be an obvious indicator of a Turk bot. Rmturkcheck provides two functions: guilty_bot(), and drop_it_like_its_bot(), which 1) identify likely bot responses, and 2) subset the original data to user-defined bot criterion. For example, if you think 10 repsondents from the exact same latitutde and longitude coordinate seems suspicious, you are probably right!

## Prepare for analyses
```{r basicconsole}
n <- 100
lat <- c( rep("42.999967", n), rnorm(n*4, mean = 44))
long <- c( rep("-80.444825", n), rnorm(n*4, mean = -83))
toy1 <- rnorm(n*5, 20)
toy2 <- rnorm(n*5, 30)
toy3 <- rnorm(n*5, 10)
toy_turk_id <- paste("faux_id:", round(runif(n*5, 0, 2),6), sep="")
df <- data.frame(lat, long, toy1, toy2, toy3, toy_turk_id, stringsAsFactors = F)
head(df)
```
