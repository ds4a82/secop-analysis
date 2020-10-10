## app.R ##
require(shinydashboard)
require(data.table)

for (file in list.files(
  c("src")
  , pattern="\\.(r|R)$"
  , recursive = TRUE
  , full.names = TRUE)) {
  source(file, local = TRUE) 
}


shinyApp(ui, server)