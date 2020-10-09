## app.R ##
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Grupo 82"),
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("EDA", tabName = "dashboard", icon = icon("dashboard"))
      , menuItem("Clustering", tabName = "widgets", icon = icon("th"))
      , menuItem("Team", tabName = "widgets", icon = icon("th"))
      , menuItem("Docs", tabName = "widgets", icon = icon("th"))
      , menuItem("Video", tabName = "widgets", icon = icon("th"))
    )
  ),
  ## Body content
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
              fluidRow(
                box(plotOutput("plot1", height = 250)),
                
                box(
                  title = "Controls",
                  sliderInput("slider", "Number of observations:", 1, 100, 50)
                )
              )
      ),
      
      # Second tab content
      tabItem(tabName = "widgets",
              h2("Widgets tab content")
      )
    )
  )
)

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
}

shinyApp(ui, server)