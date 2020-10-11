ui <- dashboardPage(
  skin = "purple"
  , dashboardHeader(title = "Grupo 82")
  , dashboardSidebar(
    sidebarMenu(id = "tabs"
                , sidebarMenuOutput("menu")
    )
  )
  , dashboardBody(
    uiOutput("navtabs")
  )
)