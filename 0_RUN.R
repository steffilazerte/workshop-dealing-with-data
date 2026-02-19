
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




# Print to pdf
#
# Use decktape docker image
#
#
# RUN IN TERMINAL
# for i in *.html; do pdf="${i%.html}.pdf"; sudo docker run --rm -t -v "$(pwd):/slides" -v ".:/home/user" ghcr.io/astefanutti/decktape reveal --fragments /home/user/"$i" "$pdf"; done
#
# Note the use of 'reveal --fragments' which may or may not be necessary in future (see https://github.com/astefanutti/decktape/issues/353)

# Pdf to small
for(i in list.files(pattern = "html")) {

  # Create PDFs
  rlang::inform(i)
  rlang::inform("  PDF small")

  n1 <- fs::path_ext_set(i, 'pdf')
  n2 <- fs::path_ext_remove(i) |>
    paste0("_sm.pdf")

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
  