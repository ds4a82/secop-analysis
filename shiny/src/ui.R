ui <- dashboardPage(skin = "purple"
                    , dashboardHeader(title = "Grupo 82"),
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
                                # infoBoxes with fill=FALSE
                                , fluidRow(
                                  # A static valueBox
                                  valueBox(10 * 2, "New Orders", icon = icon("credit-card")),
                                  
                                  # Dynamic valueBoxes
                                  valueBoxOutput("progressBox"),
                                  
                                  valueBoxOutput("approvalBox")
                                ),
                                fluidRow(
                                  # Clicking this will increment the progress amount
                                  box(width = 4, actionButton("count", "Increment progress"))
                                )
                        ),
                        
                        # Second tab content
                        tabItem(tabName = "widgets",
                                h2("Widgets tab content")
                        )
                      )
                    )
)