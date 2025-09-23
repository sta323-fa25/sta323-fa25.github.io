library(stringr)
library(readr)
## Code
str_detect(txt, "([A-Z]|[a-z]*ng")

# download.file("https://sta323-fa25.github.io/data/secret-message.txt", 
#               destfile = "secret-message.txt")
# 
# download.file("https://sta323-fa25.github.io/data/emails.txt", 
#               destfile = "emails.txt")



################
## Exercise 1 ##
################

secret_message = read_lines("data/secret-message.txt")
emails = read_lines("data/emails.txt")

## get the secret message
secret_message |>
  str_extract("sta323\\{.*\\}") |>
  str_split("[\\{\\}]")

emails |>
  str_split("@", simplify = TRUE) |>
  _[,1]

str_detect(emails, "@gmail") |>
  sum()

str_extract_all(emails, ".*@", simplify = TRUE) |>
  str_sub(start = 1L, end = -2L)


#####################
## hidden exercise ##
#####################

phones = read_lines("data/pirate-phone.txt")
str_extract_all(phones, "\\(?\\d{3}\\)?.?\\d{3}.?[0-9]{4}",
                simplify = TRUE) |>
  str_extract_all("\\d+", simplify = TRUE) |>
  apply(MARGIN = 1, str_c, collapse = "")

################
## Exercise 2 ##
################

# Navigate to file in console
## run in terminal:
### grep sta323{.*} . -ro