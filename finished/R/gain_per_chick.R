# One row per chick: days between its first and last weighing, grams put on
# over that time, and grams a day.
gain_per_chick <- function(chicks) {
  chicks |>
    arrange(chick_id, day) |>
    group_by(chick_id, diet, diet_label) |>
    summarise(
      days = last(day) - first(day),
      gain_g = last(weight_g) - first(weight_g)
    ) |>
    ungroup() |>
    mutate(gain_g_per_day = gain_g / days)
}
