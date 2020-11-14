# ---- Shiny User Interface ----
ui <- function(){shinyUI(dashboardPage(title = 'Secop Topics',
  header = dashboardHeader(
    # dropdownMenuCustom(type="messages", customSentence = customSentence)
    # , dropdownMenuOutput("notificationMenu")
    # , dropdownMenuCustom(type="tasks", customSentence = customSentence)
    title = parameters$title
    #title ='Secop Topics'
    
  )
  , sidebar = dashboardSidebar(
    sidebarMenu(id = "tabs"
    , sidebarMenuOutput("menu")
    )
  )
  , body = dashboardBody(
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
      )
      , div(class = "login", uiOutput("uiLogin"), textOutput("pass"))
      , tags$head( # Código para enviar un ping cada 15 segundos para que no se caiga la app
        HTML( # Source: https://github.com/virtualstaticvoid/heroku-buildpack-r/issues/97
          "
          <script>
          var socket_timeout_interval
          var n = 0
          $(document).on('shiny:connected', function(event) {
          socket_timeout_interval = setInterval(function(){
          Shiny.onInputChange('count', n++)
          }, 15000)
          });
          $(document).on('shiny:disconnected', function(event) {
          clearInterval(socket_timeout_interval)
          });
          </script>
          "
        )
      )
    )
    , uiOutput("navtabs")
    , div(textOutput("keepAlive")) # tiene que verse para que se actualice. Intentar colocarlo de otro color o tamaño
  )
  , skin = parameters$dash_color
))}