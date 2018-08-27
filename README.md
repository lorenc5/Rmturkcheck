# Rmturkcheck 


Rmturkcheck is an R package that facilitates the analysis of Mechanical Turk + Qualtrics single-wave and multi-wave panel studies. This document outlines the general process for implementing and checking data for a two-wave MTurk panel study fielded via the Qualtrics platform.

Many academics and survey practioners combine Mechanical Turk workers (sample) with the Qualtrics survey platform to collect experimental data to test a variety of theories/hypotheses. Rmturkcheck evaluates data arriving in this format. Typically, MTurk samples will include respondent MTurk ids (or you will ask for IDs for two-wave panels), response ids, Internet Protocol (IP) address, and possibly other information. Qualtrics data typically also includes a latitude and longitude coordinate. Thus, when the survey is complete, users download a .csv file including the aforementioned fields plus answers to their survey questions and possible flags for experimental conditions.

However, this process has potential for contamination/error, including (but not limited to):

* 1. The same respondent(s) taking the survey more than once
* 2. Respondents giving fake answers or not actually reading the survey
* 3. Bots automating responses providing essentially fake data.

To address point 1, Rmturkcheck includes a function, clean_turk_id(), which cleans the unique mturk id field and reports the number of identical mturk ids.

Survey analysts and experimentalists typically embed attention checks into their surveys to address point 2. 

Recent discoveries suggests that identical respondent latitude/longitude coordinates may be an obvious indicator of a Turk bot. Rmturkcheck provides two functions: guilty_bot(), and drop_it_like_its_bot(), which 1) identify likely bot responses, and 2) subset the original data to user-defined bot criteria. For example, if you think 10 respondents from the exact same latitutde and longitude coordinate seems suspicious, you are probably right!

## Toy Example 
```{r}
n <- 100
lat <- c( rep("42.999967", n), rnorm(n*4, mean = 44))
long <- c( rep("-80.444825", n), rnorm(n*4, mean = -83))
toy1 <- rnorm(n*5, 20)
toy2 <- rnorm(n*5, 30)
toy3 <- rnorm(n*5, 10)
toy_turk_id <- c("faux_id:2390 ","faux_id:2390 ", " ", paste("faux_id:", round(runif((n*5)-3, 0, 2),6), sep=""))
df <- data.frame(lat, long, toy1, toy2, toy3, toy_turk_id, stringsAsFactors = F)
head(df)
```

The above data include two identical MTurk ids and one missing ID. We can use clean_turk_id() to check this, which resports the number of unique ID and missing elements and tags on a variable to the end of the dataset you can use for subsetting, etc.

```{r}
# Check for Turk ID duplicates, missing IDs, tag on variable to dataet
df$turk_id_clean <- clean_turk_id(df$toy_turk_id)
df2 <- df[na.omit(df$turk_id_clean),]; dim(df2)
```

Next, we check fo super guilty bots to evaluate them in depth. These low-life bots... guilty_bot() takes the lat/long variable names and the dataset, producing a string indicating which bot coordinates are most guilty, then also a dataframe of guilty bots you can then drop from your original dataset.

```{r}
# Produce dataset of most guilty responses #
no_soup_for_you <- guilty_bot(lat = "lat", long = "long", dat = df)

# Keep only non-bot data
keep <- !df$toy_turk_id %in% no_soup_for_you$toy_turk_id
df_bot_free <- df[keep,]; uniqueN(df_bot_free$toy_turk_id)
head(df_bot_free)
```

Finally, we might want to drop respondents that fit certain bot-like criteria (i.e., having more than 3 exact same lat/long coordinates in your data when that lat/long is some point in the middle of a Minnesota lake). drop_it_like_its_bot() produces a new dataset, and also reports potential bot-rate in your data. You should now be able to run all analysis on this new dataset. guilty_bot() and drop_it_like_its_bot() can be thought of as inverses of one another.

```{r}
# Drop responses that have more than 3 identical Lat/Longs in the data #
toy_bot <- drop_it_like_its_bot(lat = "lat", long = "long", dat = df,
                                remove_suspect = "more_than", more = 3)
```

