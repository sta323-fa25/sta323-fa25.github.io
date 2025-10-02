# edit paths:
library(tidyverse)
# grades <- readxl::read_xlsx("~/Downloads/Grades(1).xlsx")


grades |>
  select(Student, ID, `SIS User ID`, `SIS Login ID`, Section,
         quiz01, quiz02) |> # edit assignments 
  mutate(across(c(quiz01, quiz02), ~replace_na(., 0))) |>
  write_csv(paste0("~/Downloads/upload323-", Sys.Date(), ".csv"))
