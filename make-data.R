# Writes the practice data into starter/ and finished/, from R's built-in
# ChickWeight. Run from the root of this folder.
library(tidyverse)
library(fs)
library(here)

# ChickWeight stores chick and diet as factors; the export has plain numbers
chick_weights <- as_tibble(datasets::ChickWeight) |>
  mutate(
    chick_id = as.integer(as.character(Chick)),
    diet = as.integer(as.character(Diet))
  )

# Three weighings recorded as -99, the export's code for "not weighed": the
# last weighing of chicks 35 and 40 (diet 3), and day 10 of chick 7 (diet 1)
chick_weights_coded <- chick_weights |>
  mutate(
    weight_recorded = if_else(
      (chick_id %in% c(35, 40) & Time == 21) | (chick_id == 7 & Time == 10),
      -99,
      weight
    )
  )

# Column names as a spreadsheet export would have them
chick_weights_export <- chick_weights_coded |>
  arrange(chick_id, Time) |>
  select(
    `Chick ID` = chick_id,
    Diet = diet,
    Day = Time,
    `Weight (g)` = weight_recorded
  )

# Made-up labels; ChickWeight doesn't say what the diets were
diet_labels <- tibble(
  diet = 1:4,
  diet_label = c("Feed A", "Feed B", "Feed C", "Feed D")
)

dir_create(here("starter", "data-raw"))
dir_create(here("finished", "data-raw"))

write_csv(
  chick_weights_export,
  here("starter", "data-raw", "chick-weights.csv")
)
write_csv(
  chick_weights_export,
  here("finished", "data-raw", "chick-weights.csv")
)
write_csv(diet_labels, here("starter", "data-raw", "diets.csv"))
write_csv(diet_labels, here("finished", "data-raw", "diets.csv"))
