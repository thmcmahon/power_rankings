library(dplyr)
library(superrugby)
library(PlayerRatings)

s15 <- superrugby %>% 
  filter(comp == "S15") %>%
  mutate(result_elo = ifelse(result == "Home Win", 1,
                             ifelse(result == "Away Win", 0, .5))) %>%
  select(season, round, home, away, result = result_elo)

s15$round <- as.character(s15$round)
s15$home <- as.character(s15$home)
s15$away <- as.character(s15$away)
s15$season <- droplevels(s15$season)

s15$round[s15$round == "Elim"] <- "21"
s15$round[s15$round == "Semi"] <- "22"
s15$round[s15$round == "Final"] <- "23"

s15$round <- as.integer(s15$round)
s15$combined_round <- as.integer(ordered(as.integer(paste(s15$season, s15$round, sep = ""))))