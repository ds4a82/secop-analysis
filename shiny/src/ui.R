# ---- Shiny User Interface ----
ui <- function(){shinyUI(dashboardPage(
  header <- dashboardHeader(
    # dropdownMenuCustom(type="messages", customSentence = customSentence)
    # , dropdownMenuOutput("notificationMenu")
    # , dropdownMenuCustom(type="tasks", customSentence = customSentence)
    title = parameters$title
  )
  , dashboardSidebar(
    sidebarMenu(id = "tabs"
    , sidebarMenuOutput("menu")
    )
  )
  , dashboardBody(
    shinyjs::useShinyjs()
    , fluidPage(
      tagList(
        # The call to singleton ensures it's only included once
        # in a page. It's not strictly necessary in this case, but
        # it's good practice.
        singleton(tags$script(type = "text/javascript", src = parameters$md5))
          , singleton(tags$script(src = parameters$messageHandler))
          , singleton(tags$script(type = "text/javascript", src = parameters$inputBinding))
          , singleton(tags$link(rel = "shortcut icon", href= parameters$favicon))
      ), div(class = "login", uiOutput("uiLogin"), textOutput("pass"))
    )
    , uiOutput("navtabs")
  )
  , skin = parameters$dash_color
))}