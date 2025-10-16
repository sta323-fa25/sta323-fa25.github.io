library(ghclass)

####################################
## Team based assignment creation ##
####################################. 
#
## ATTENTION
### MAKE SURE YOU PUT ALL ROSTER IN 1 EXCEL SHEET
##################################################

roster = readxl::read_xlsx("~/Downloads/teams-323-10-7.xlsx")

# edit "lab-x" below

org_create_assignment(
  org = "sta323-fa25",
  user = roster$github,
  repo = paste0("lab-5-", roster$team),
  team = roster$team,
  source_repo = "sta323-fa25/lab-5",
  private = TRUE
)