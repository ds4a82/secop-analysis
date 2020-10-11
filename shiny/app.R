## app.R ##
require(shiny)
require(shinydashboard)
require(data.table)

for (file in list.files(
  c("src")
  , pattern="\\.(r|R)$"
  , recursive = TRUE
  , full.names = TRUE)) {
  source(file, local = TRUE) 
}

shinyApp(ui, server, options = list(port = 8787, launch.browser = F, test.mode = T))
