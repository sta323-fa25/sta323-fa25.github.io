library(ghclass)

####################################
## Team based assignment creation ##
####################################. 
#
## ATTENTION
### MAKE SURE YOU PUT ALL ROSTER IN 1 EXCEL SHEET
##################################################

roster = readxl::read_xlsx("~/Downloads/teams_final.xlsx")

# edit "lab-x" below

org_create_assignment(
  org = "sta323-fa25",
  user = roster$github,
  repo = paste0("project-", roster$team),
  team = roster$team,
  source_repo = "sta323-fa25/project",
  private = TRUE
)