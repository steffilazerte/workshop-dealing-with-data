library(magick)
library(writexl)
library(readr)
library(dplyr)
library(ggplot2)

# Create figures --------------------------------------------------------

f1 <- image_read("../Common/steffi_and_nami.jpg") |>
  image_crop("80%x90%+500+0")
f2 <- image_read("../Common/alex_and_nami.jpg") |>
  image_crop("80%x100%+400+0")
f3 <- image_read("../Common/vivi_canoe.jpg") |>
  image_crop("80%x100%+150+0")

c(f1, f2, f3) |>
  image_scale() |>
  image_append() |>
  image_write("figures/creatures.jpg", format = "jpg")

image_read("https://raw.githubusercontent.com/allisonhorst/stats-illustrations/533ec9b9b1e3b6bf2cbc85a1a9f3181693315705/rstats-artwork/r_first_then.png") |>
  image_trim(fuzz = 5) |>
  image_crop("100%x47%+0+0") |>
  image_write("figures/horst_monster1.jpg", format = "jpg")

image_read("https://raw.githubusercontent.com/allisonhorst/stats-illustrations/533ec9b9b1e3b6bf2cbc85a1a9f3181693315705/rstats-artwork/r_first_then.png") |>
  image_crop("100%x54%+0+1240") |>
  image_trim(fuzz = 21) |>
  image_write("figures/horst_monster2.jpg", format = "jpg")

# Create figure for lecture 2 title slide
ggplot(data = palmerpenguins::penguins,
       aes(x = species, y = flipper_length_mm, fill = species)) +
  theme_bw() +
  geom_boxplot(na.rm = TRUE) +
  scale_fill_viridis_d() +
  geom_count()
ggsave("figures/viz_fig.png", width = 8, height = 6)

# Create data ------------------------------
r_clean <- read_csv("data/Originals/rivers.csv") %>%
  mutate(River = as.character(River),
         Site = as.character(Site),
         Temperature = withr::with_seed(111, rnorm(300, 10, sd = 4)),
         Temperature = if_else(Temperature < 0, -99, Temperature),
         Year = rep(2019:2023, 300/5),
         Amount = if_else(Amount == 0, NA_real_, Amount))
r <- r_clean
#r$Amount[44] <- "<0.1"
r$River[3] <- "Grase"
r$River[98] <- "grasse"
r$River[104] <- "raquette"

names(r) <- c("River Name", "Site", "Ele", "Amo", "Temperature C°", "Year")
r$Wea <- sample(c("sunny", "cloudy", "wet", "snowy"), nrow(r), replace = TRUE)
write_csv(r, "data/water_raw.csv")
#write_xlsx(r, "data/water_correct.xlsx")
# NOTE THAT second sheet is added manually


library(openxlsx)
wb <- createWorkbook()
addWorksheet(wb, "Sheet1")
addWorksheet(wb, "Oswegatchie")
b <- createStyle(textDecoration = "Bold")
writeData(wb, 1, r_clean |> janitor::clean_names(), startRow = 1, headerStyle = b)
writeData(wb, 2, "Subset for Oswegatchie only")
writeData(wb, 2, filter(r_clean, River == "Oswegatchie") |> janitor::clean_names(), startRow = 3, headerStyle = b)
saveWorkbook(wb, "data/water_cleaned.xlsx", overwrite = TRUE)


# zinke <- read_csv("data/zinke_soil.csv")
# zinke$Code <- "A"
# zinke$Code[2000:3000] <- "B"
# zinke$Code[3001:4118] <- "C"
# zinke$Code[14] <- "a"
# zinke$Code[1000] <- "Aa"
# write_csv(zinke, "data/zinke.csv")

geo <- read_csv("~/Projects/cavityuse - project/Data/detailed/c17 female_000.csv",
                n_max = 100, skip = 1,
                col_names = FALSE) %>%
  select(X2, X4) %>%
  #slice(20:40) %>%
  write_csv(file = "data/geolocators.csv", col_names = FALSE)


g <- read_csv("data/Originals/SP6 CSP_grain size distribution_profiles-horizonwise_final.csv") %>%
  select(-silt_sum, -sand_sum, -sample_num, -lab_num) %>%
  rename(plot = CSP,
         depth = depth_lb,
         coarse_sand = csa,
         medium_sand = msa,
         fine_sand = fsa,
         veryfine_sand = vfsa,
         coarse_silt = csi,
         medium_silt = msi,
         fine_silt = fsi) %>%
  mutate(fine_sand = fine_sand + veryfine_sand) %>%
  select(-veryfine_sand)

loc <- tibble(plot = unique(g$plot),
              habitat = sample(c("forest", "grassland", "clearcut"), size = 27, replace = TRUE),
              technician = sort(rep(c("Jason", "Yasir", "Catharine"), 9)),
              date = sample(seq(as.Date("2008-07-01"), as.Date("2009-06-1"), length.out = 27), size = 27)) %>%
  arrange(plot)

write_csv(g, "data/grain_size2.csv")
write_csv(loc, "data/grain_meta.csv")
