# Sys.setenv(TAR_PROJECT = "starter")
# Which diet grows chicks fastest?
source(here::here("starter/packages.R"))
tar_source("starter/R")

tar_assign({
  chicks_path <- "starter/data-raw/chick-weights.csv" |> tar_file()

  chicks_raw <- read_csv(chicks_path) |> clean_names() |> tar_target()

  chicks <- tidy_chicks(chicks_raw) |> tar_target()
  chick_gain <- gain_per_chick(chicks_tidy) |> tar_target()
  diet_gain <- gain_per_diet(chick_gain) |> tar_target()

  gg_weights <- tar_target(
    ggplot(
      chicks_tidy,
      aes(x = day, y = weight_g, group = chick_id, colour = diet_label)
    ) +
      geom_line()
  )

  gg_gain <- tar_target(
    ggplot(chick_gain, aes(x = diet_label, y = gain_g_per_day)) +
      geom_boxplot()
  )

  report <- tar_quarto(path = "starter/report.qmd")
})
