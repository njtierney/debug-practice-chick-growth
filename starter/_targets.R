# Which diet grows chicks fastest?
source("packages.R")
tar_source()

tar_assign({
  chicks_path <- "data-raw/chick-weights.csv" |> tar_file()

  chicks_raw <- read_csv(chicks_path) |> clean_names() |> tar_target()

  chicks <- tidy_chicks(chicks_raw) |> tar_target()
  chick_gain <- gain_per_chick(chicks_tidy) |> tar_target()
  diet_gain <- gain_per_diet(chick_gain) |> tar_target()

  gg_weights <- tar_target(
    ggplot(
      chicks,
      aes(x = day, y = weight_g, group = chick_id, colour = diet_label)
    ) +
      geom_line()
  )

  gg_gain <- tar_target(
    ggplot(chick_gain, aes(x = diet_label, y = gain_g_per_day)) +
      geom_boxplot()
  )

  report <- tar_quarto(path = "report.qmd")
})
