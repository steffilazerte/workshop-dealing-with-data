
# Download figures as needed
library(dplyr)
library(purrr)

tribble(
  ~type, ~file, ~url,
  "logo-rstudio", "logo_rstudio.png", "https://d33wubrfki0l68.cloudfront.net/3099a8a5ab437c8cca2446dfb08383ecfca761ec/0377b/wp-content/uploads/2014/06/rstudio-ball.png",
  "logo-r", "logo_r.png", "https://www.r-project.org/logo/Rlogo.png",
  "horst-spelling", "horst_spelling.png", "https://cdn.myportfolio.com/45214904-6a61-4e23-98d6-b140f8654a40/d4f90788-7a14-4d44-94ab-da13dd41f009.png?h=585957612c146dc43c4aa63e9431ad1b",
  "horst-dragons", "horst_dragons.png", "https://cdn.myportfolio.com/45214904-6a61-4e23-98d6-b140f8654a40/5b2f0471-3b10-46f6-991c-6ab6a09426fd.png?h=b16ac1d69780c68bfa258d65d91b42ba",
  "hex-patchwork", "hex_patchwork.svg", "https://patchwork.data-imaginist.com/logo.svg",
  "hex-asiar", "hex_asiar.png", "https://avatars.githubusercontent.com/u/93941395?s=200&v=4",
  "hex-africar", "hex_africar.png", "https://r4africa.org/home/rusers-logo.png",
  "hex-mir", "hex_mir.png", "https://mircommunity.com/about/sidebar/avatar.jpg",
  "horst-patchwork", "horst_patchwork.png", "https://cdn.myportfolio.com/45214904-6a61-4e23-98d6-b140f8654a40/74f015a1-4d22-4b59-9fd0-69ca676d3f05.png?h=43e09339ee8d339f86981ca55485bad7",
  "horst-case1", "horst_case1.png", "https://cdn.myportfolio.com/45214904-6a61-4e23-98d6-b140f8654a40/dbb99049-2916-4bc8-824f-1816f5c4f06d.png?h=ba6a62f15223e9ba5c166341ecf935f2",
  "horst-case2", "horst_case2.png", "https://cdn.myportfolio.com/45214904-6a61-4e23-98d6-b140f8654a40/8118ca19-a900-4a1c-9191-6b702a52f820.png?h=71de3d7f743831e3857022d196ba00a0"
  ) |>
  mutate(destfile = file.path("figures", file)) |>
  select(url, destfile) |>
  filter(!file.exists(destfile)) |>
  pwalk(download.file)

magick::image_read_svg("figures/hex_patchwork.svg") |>
  magick::image_write("figures/hex_patchwork.png")


# horst_patchwork
# "Fuzzy cartoon monsters in white gloves and uniforms hanging multiple plots together on a wall, with an artist monster wearing a beret and smock directing them to the correct orientation. There is a blueprint plan on the wall showing how the plots should be arranged. Stylized title font reads \"patchwork - combine & arrange your ggplots!\""

# R learners (we believe in you)
# https://cdn.myportfolio.com/45214904-6a61-4e23-98d6-b140f8654a40/5ccff989-900e-4f2b-aece-55278b563cfa.png?h=ef8e944e5633d60890b3a74c39c74856
# "Header text 'R learners' above five friendly monsters holding up signs that together read 'we believe in you.'"


# horst_ggplot2
# "A fuzzy monster in a beret and scarf, critiquing their own column graph on a canvas in front of them while other assistant monsters (also in berets) carry over boxes full of elements that can be used to customize a graph (like themes and geometric shapes). In the background is a wall with framed data visualizations. Stylized text reads \"ggplot2: build a data masterpiece.\""

# horst_need_a_moment
# "A frustrated little monster sits on the ground with his hat next to him, saying \"I just need a minute.\" Looking on empathetically is the R logo, with the word \"Error\" in many different styles behind it."

# horst_dragons
# "Three very different looking dragons stand side by side. On the left, a very small blue dragon with spiky hair and no pattern. In the center, a green striped dragon. On the right, a large purple dragon with spots."

# horst_spelling
# "Comic panels of an alligator trying to debug some code. First panel: A confident looking alligator gets an error message. Second panel: a few minutes later, the error remains and the alligator is looking carefully at their code. Third panel: 10 minutes after that, the error remains and the alligator is giving a frustrated \"RAAAR\" while desperately typing. Fourth panel: The error remains, and the alligator looks exhausted and exasperated, and a thought bubble reads \"maybe it's a bug.\" Fifth panel: A friendly flamingo comes over to take a look, and reads aloud from the problematic code a spelling error: \"L-E-N-G-H-T.\" Only the tail of the alligator is visible as it stomp stomp stomps out of the panel roaring."

# horst_monster1
# "An R-logo with a scary face, and a small scared little fuzzy monster holding up a white flag in surrender while under a dark storm cloud. The text above says \"at first I was like…\""
# horst_monster2
# "A friendly, smiling R-logo jumping up to give a happy fuzzy monster a high-five under a smiling sun and next to colorful flowers. The text above reads \"but now it’s like…\""

# horst_case1
# "Cartoon representations of common cases in coding. A snake screams "SCREAMING_SNAKE_CASE" into the face of a camel (wearing ear muffs) with \"camelCase\" written along its back. Vegetables on a skewer spell out \"kebab-case\" (words on a skewer). A mellow, happy looking snake has text \"snake_case\" along it."

# horst_case2
# "Joke, totally made up failed programming cases. ducklingcasE (all lowercase, represented as small ducklings, until the last letter as the mama duck). BatCase (written upside down, on a bat cartoon). SH__K_CASE (shark case - screaming snake but with big chunks taken out -- a shark is below chomping on the missing AR. Lobster case: snake_case but backwards, written on a lobster carapace moving in reverse."

# horst_lubridate
# "Fuzzy cartoon monsters in construction hats sorting a pile of \"Y\" \"M\" and \"D\" into separate piles labeled \"Years\", \"Months\" and \"Days\". Title text reads \"Lubridate: wrangle times and dates!\""

# horst_mutate
# "Cartoon of cute fuzzy monsters dressed up as different X-men characters, working together to add a new column to an existing data frame. Stylized title text reads \"dplyr::mutate - add columns, keep existing.\""

# horst_ungroup
# "Two fuzzy monsters in the foreground in birthday party hats celebrate together because one has opened a gift with group_by() inside. Text above those two reads \"Other really important parts sold separately!\" In the background, a very hopeful little monster stands along holding a package labeled \"ungroup\", waiting to be invited."

# horst_tidydata1
# "Stylized text providing an overview of Tidy Data. The top reads \"Tidy data is a standard way of mapping the meaning of a dataset to its structure. - Hadley Wickham\". On the left reads "In tidy data: each variable forms a column; each observation forms a row; each cell is a single measurement." There is an example table on the lower right with columns 'id', 'name' and 'color' with observations for different cats, illustrating tidy data structure."

# horst_tidydata2
# "There are two sets of anthropomorphized data tables. The top group of three tables are all rectangular and smiling, with a shared speech bubble reading \"our columns are variables and our rows are observations!\"Text to the left of that group reads \"The standard structure of tidy data means that \"tidy datasets are all alike…\" The lower group of four tables are all different shapes, look ragged and concerned, and have different speech bubbles reading (from left to right) \"my column are values and my rows are variables\", \"I have variables in columns AND in rows\", \"I have multiple variables in a single column\", and \"I don't even KNOW what my deal is.\" Next to the frazzled data tables is text \"...but every messy dataset is messy in its own way. -Hadley Wickham.\""

# horst_tidydata3
# "Cute fuzzy monsters putting rectangular data tables onto a conveyor belt. Along the conveyor belt line are different automated \"stations\" that update the data, reading \"WRANGLE\", \"VISUALIZE\", and \"MODEL\". A monster at the end of the conveyor belt is carrying away a table that reads \"Complete analysis.\""

# horst_knowing_so_little
# "Illustrated line plot of \"How much I think I know about R\" on the y-axis, and \"Time\" on the x-axis. Along the line are emoji-style faces, showing the non-linear progression of R knowledge over time. At first, a nervous face becomes a happy face early on in learning, then a \"grimace\" face at an intermediate peak before a steep decline (with an exhausted face at the local minimum). Then, a determined face charges back up a hill, reaching another peak with a \"mind blown\" face and text annotation \"join R community on twitter\" followed by another decline, but this time the faces look happy even though their \"How much I think I know about R\" value is declining."

# horst_debugging
# "A cartoon of a fuzzy round monster face showing 10 different emotions experienced during the process of debugging code. The progression goes from (1) \"I got this\" - looking determined and optimistic; (2) \"Huh. Really thought that was it.\" - looking a bit baffled; (3) \"...\" - looking up at the ceiling in thought; (4) \"Fine. Restarting.\" - looking a bit annoyed; (5) \"OH WTF.\" Looking very frazzled and frustrated; (6) \"Zombie meltdown.\" - looking like a full meltdown; (7) (blank) - sleeping; (8) \"A NEW HOPE!\" - a happy looking monster with a lightbulb above; (9) \"insert awesome theme song\" - looking determined and typing away; (10) \"I love coding\" - arms raised in victory with a big smile, with confetti falling."

# horst_communities
# "Two fuzzy monsters standing side-by-side outside of a door frame through which is a magical wonderland of different R communities, with a \"mind blown\" rainbow coming out of the one closest to the door. A welcome mat says \"Welcome.\""
