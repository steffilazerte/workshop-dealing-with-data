
f <- tibble::tibble(
  file = c("1_intro_to_R", "2_visualizations", "3_loading_and_cleaning",
           "4_summarizing_and_transforming", "5_getting_help"),
  answer = paste0(file, "_answers.html"),
  qmd = paste0(file, ".qmd"),
  html = paste0(file, ".html"))

# Answers - Just not the last one (which has no answers)
for(i in seq_len(nrow(f) - 1)) {
  #i <- 2
  quarto::quarto_render(input = f$qmd[i], output_file = f$answer[i],
                        cache_refresh = TRUE,
                        execute_params = list(answers = "visible"))
}

# No Answers - All
quarto::quarto_render(cache_refresh = TRUE,
                      execute_params = list(answers = "hidden"))

# Fix and Re-run - Singles
# i <- 2
# quarto::quarto_render(input = f$qmd[i], cache_refresh = TRUE,
#                        execute_params = list(answers = "hidden"))
# quarto::quarto_render(input = f$qmd[i], output_file = f$answer[i],
#                       cache_refresh = TRUE,
#                       execute_params = list(answers = "visible"))


f <- list.files(pattern = "html")

# Pdf
for(i in f) {

  # Create PDFs
  rlang::inform(f)
  rlang::inform("  PDF")
  pagedown::chrome_print(i, extra_args = "--font-render-hinting=none")

  n1 <- fs::path_ext_set(i, 'pdf')
  n2 <- fs::path_ext_remove(i) |>
    paste0("_sm.pdf")

  rlang::inform("  PDF small")
  # Reduce size (prepress = 300 dpi, printer = 300 dpi, ebook = 150 dpi, screen = 72dpi)
  system(glue::glue("gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 ",
                    "-dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH ",
                    "-sOutputFile='{n2}' '{n1}'"))
}

fs::file_move(list.files(pattern = ".pdf"), "pdf/")

# Wrap up ---------------------------------------
# - Post answers
# - Link to answers in README
# - Create signed release
# - Create certificates
# - Send out certificates
usethis::use_github_release(publish = FALSE)
