# One row per diet: how many chicks, and their mean grams a day, fastest first.
gain_per_diet <- function(chick_gain) {
  chick_gain |>
    group_by(diet, diet_label) |>
    summarise(
      n_chicks = n(),
      mean_gain_g_per_day = mean(gain_g_per_day)
    ) |>
    ungroup() |>
    arrange(desc(mean_gain_g_per_day))
}
