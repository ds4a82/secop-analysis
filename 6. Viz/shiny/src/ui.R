# ---- Shiny User Interface ----
ui <- function(){shinyUI(dashboardPage(title = 'Secop Topics',
  header = dashboardHeader(
    title = parameters$title
    , tags$li(class="dropdown",tags$a(href="https://github.com/ds4a82/secop-analysis", icon("github"), "Source Code", target="_blank"))
  )
  , sidebar = dashboardSidebar(
    sidebarMenu(id = "tabs"
    , sidebarMenuOutput("menu")
    )
  )
  , body = dashboardBody(
    shinyjs::useShinyjs()
    , fluidPage(
      tags$head( # Google Tag Manager
        HTML( 
          "
<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-N7QGLVF');</script>
<!-- End Google Tag Manager -->

          "
        )
      )
      , tags$body(
      HTML('
                  <!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-N7QGLVF"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->

                  ')
      )
      , disconnectMessage( # In case de app disconnects
        text = "Your session has timed out.",
        refresh = "Refresh",
        background = "#404040E6",
        colour = "#FFFFFF",
        overlayColour = "#999999",
        overlayOpacity = 0.7,
        width = "full",
        top = "center",
        size = 30,
        css = "padding: 10px !important; box-shadow: none !important;"
      )
      , tagList(
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
          }, 10000)
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
    , div(span(textOutput("keepAlive"), style = "color:white")) # tiene que verse para que se actualice
  )
  , skin = parameters$dash_color
))}