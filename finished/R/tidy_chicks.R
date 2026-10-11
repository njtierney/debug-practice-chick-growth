# One row per weighing: drops weighings recorded with the missing code, and
# joins on each diet's label.
tidy_chicks <- function(chicks_raw, diets, missing_code = -99) {
  chicks_raw |>
    filter(weight_g != missing_code) |>
    left_join(diets, by = join_by(diet))
}
