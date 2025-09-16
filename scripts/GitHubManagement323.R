#############################################
## install ghclass with artifact functions ##
#############################################
# remotes::install_github("rundel/ghclass@artifacts")
library(ghclass)
library(tidyverse)
##############################
### to grab the html files ###
##############################
repos_of_interest = ghclass::org_repos("sta323-fa25", filter="lab-0")
ghclass::action_artifact_download(repos_of_interest, dir = "~/Desktop/sta323-test")

##############################
### to clean up artifacts ###
##############################
repos_of_interest = ghclass::org_repos("sta323-fa25", filter="lab-0")
ghclass::action_artifact_delete(repos_of_interest, ids=action_artifacts(repos_of_interest, which="all"))


#########
## deploy team repos
#########

# example data frame for demo purposes
# you will need to format your data frame to look like this
roster = data.frame(
  github = c("fishswish", "athos00"),
  lab3 = rep("lab-3-teamfish", 2)
)

# edit each item below
org_create_assignment(
  org = "sta323-fa25",
  user = roster$github,
  repo = roster$lab3,
  team = roster$lab3,
  source_repo = "sta323-fa25/lab-3",
  private = TRUE
)


## Make teams (once)

team_names <- readxl::read_xlsx("~/Downloads/sta323_lab3_teams.xlsx") %>%
  select(team) %>%
  pull()

all_team = readxl::read_xlsx("~/Downloads/sta323_lab3_teams.xlsx")

org <- "sta323-fa25"

# create teams
team_create(org, team_names)

# invite to teams
for(team_name in team_names) {
  users = all_team %>%
    filter(team == team_name) %>%
    select(github) %>%
    pull()
  
  team_invite(org, user = users, team = team_name)
}

# many teams at once (helpful for assignments)
# team_create(org, paste0("hw1-team", sprintf("%02d", 1:10)))

# vector of GitHub usernames
students <- c("athos00", "fishswish")

# add them to a team; creates the team if missing by default
team_invite(org, user = students, team = "test-team")

