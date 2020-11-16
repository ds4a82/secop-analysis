# ---- Shiny Server ----
library(digest)
server <- function(input, output, session) {
  print(sprintf("Initialiting Server - %s", Sys.time()))  
  # Abrir panel de acciones
  openDashboard <- function(){
    shinyjs::removeClass(selector = "body", class = "sidebar-collapse")
    shinyjs::removeClass(selector = "header", class = "hidethis")
    shinyjs::addClass(selector = "header", class = "showthis")
    output$menu <- renderMenu({
      sidebarMenu(
        id="menu"
        , lapply(menu, function(i){
          if(i$active){menuItem(i$name, tabName = i$tab, icon = icon(i$icon))}
        })
      )
    })
    output$navtabs <- renderUI({
      # load modules and prepare tabItems (content)
      tabItemsArgs <- lapply(menu, function(module){
        if(module$active){
          callModule(get(module$tab), module$tab)
          tabItem(tabName = module$tab, get(sprintf("%sUI", module$tab))(module$tab))
        }
      })
      tabItemsArgs[sapply(tabItemsArgs, is.null)] <- NULL
      tabItemsArgs <- unname(tabItemsArgs)
      do.call(tabItems, tabItemsArgs)
    })
    # Si se pasa un tab de entrada, una ves la página quede cargada, carga ese tab. si no se pasa, carga el de gerencia por default
    query <- parseQueryString(session$clientData$url_search)
    if("page" %in% names(query)){
      isolate(updateTabItems(session, "tabs", query$page))
    } else {
      isolate(updateTabItems(session, "tabs", parameters$tab))
    }
  }

  # ---- Variables del servidor ----
  shinyjs::extendShinyjs(parameters$shinyjs, functions = c("updateHistory"))

  # USER <- callModule(login, login_id)
  # observe(print(USER$Logged))

  # Taken from: https://gist.github.com/withr/9001831
  USER <- reactiveValues(Logged = parameters$Logged)

  # ---- Manejo de Parámetros pasados por URL ----
  # observe({
  #   # query guardará la parte del link que venga después de la ?. Funcionará como un list con valores y keyvalues.
  #   # Parámetros del URL: ?(usuario)&(contraseñaMD5)&(tab de entrada)
  #   query <- parseQueryString(session$clientData$url_search)
  #   logical <- parameters$credential[Un %in% query$user, query$psw %in% Passord]
  #   if(length(logical) > 0){
  #     USER$Logged <- logical
  #   }
  # })
  
  output$uiLogin <- renderUI({
    if (USER$Logged == FALSE) {
      shinyjs::addClass(selector = "body", class = "sidebar-collapse")
      shinyjs::addClass(selector = "header", class = "hidethis")
      tagList(
        div(id = "login"
            , br()
            , img(src= parameters$top_img, align = "center")
            , br()
            , wellPanel(
              textInput("userName", "Nombre de usuario")
              , passwordInput("passwd", "Contraseña")
              , br()
              , withBusyIndicatorUI(actionButton("Login", "Conectar"))
            )
            , a(img(
              src = parameters$bottom_im
              , align = "center"
              , height = 100
              ), href = "http://www.fidelio.com.co")
        )
        , tags$style(
          type ="text/css"
          , "#login {
          font-size:14px; 
          text-align: center;
          position:absolute;
          top: 30%;
          left: 50%;
          margin-top: -100px;
          margin-left: -150px;}"
        )
      )    
    }
  })

  # ---- Mensaje de confirmación de login. ----
  output$pass <- renderText({
    if (USER$Logged == FALSE) {
      if (!is.null(input$Login)) {
        if (input$Login > 0) {
          Username <- isolate(input$userName)
          Password <- isolate(input$passwd)
          logical <- parameters$credential[
            Un %in% Username
            , digest(object = Pd, algo = "md5", serialize = F) == Password]
          if(length(logical) > 0){
            if(logical){
              USER$Logged <- logical
            } else {
              "Nombre de usuario o contraseña incorrectos."
            }
          } 
        }
      }
    }
  })
  
  # ---- Cargue de la página de Login ----
  
  # Este observe se activa cuando el botón de Conectar recibe un click. 
  # Inician la animación del archivo ajax-loader-bar.gif hasta que se cambie de ui. 
  # El ui se cambia apenas se confirma el usuario y contraseña.
  # Taken from https://github.com/daattali/advanced-shiny/blob/master/busy-indicator/app.R
  observe(withBusyIndicatorServer("Login", {{
    if (USER$Logged == TRUE) {
      openDashboard()
    }
  }}))
  
  #Creates dynamic notification menu that is as long as the filter data frame notifcationData, with text given by the text parameter in notificationItem
  output$notificationMenu <- renderMenu({
    # Code to generate each of the messageItems here, in a list. This assumes
    # that messageData is a data frame with two columns, 'from' and 'message'.

    #     od <- as.data.table(pool::dbGetQuery(
    #         ikonocrm
    #         , parameters$crm_query_op_desactualizadas
    #     ))
    #     if(parameters$demostration){
    #         od <- convert2Demo(od)
    #     }
    # 
    #   ntfs <- apply(od, 1, function(row) {
    #   notificationItem(text = tags$div(
    #     "La oportunidad de " 
    #     # "row["Fecha_Modificacion"], "sin cambios."
    #     , tags$br()
    #     , paste(row[["Vendedor"]],"con ", row[["OID"]], "lleva ")
    #     , tags$br()
    #     , paste(row[["Dias"]], " días sin cambios.")
    #     , style = "display: inline-block; vertical-align: middle;"
    #   ))
    # })
    # dropdownMenuCustom(
    #   type = "notifications",
    #   customSentence = customSentence,
    #   .list = ntfs)
  })
  
  
  # ---- Print on console all client data ----
  observeEvent(session$clientData, {
    cdata <- session$clientData
    cnames <- names(cdata)

    allvalues <- lapply(cnames, function(name) {
      paste(name, cdata[[name]], sep=" = ")
    })
    cat(paste(allvalues, collapse = "\n"))
  })
  
  output$keepAlive <- renderText({ # Code to keep alive the app when running
    req(input$count)
    paste("keep alive ", input$count)
  })
  # ---- Stop shiny app when browser tab is closed ---- 
  # session$onSessionEnded(stopApp) # For debugging pusposes. Restore to allow reconnect
  session$allowReconnect(TRUE) # Permitir reconectar a la session que se tenía previamente
  options(shiny.sanitize.errors = TRUE)
}