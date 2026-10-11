# One row per weighing, with each diet's label joined on.
tidy_chicks <- function(chicks_raw) {
  diets <- read_csv("data-raw/diets.csv") |> clean_names()

  chicks_raw |>
    left_join(diets, by = join_by(diet))
}
