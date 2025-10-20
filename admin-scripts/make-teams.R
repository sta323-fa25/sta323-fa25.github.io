library(ghclass)
library(tidyverse)
## Make teams (once)

all_teams <- readxl::read_xlsx("~/Downloads/teams_final.xlsx") 

team_names <- all_teams %>%
  select(team) %>%
  pull()

org <- "sta323-fa25"

# create teams
team_create(org, team_names)

# invite to teams
for(team_name in team_names) {
  users = all_teams %>%
    filter(team == team_name) %>%
    select(github) %>%
    pull()
  
  team_invite(org, user = users, team = team_name)
}