server <- function(input, output, session) {
  # Abrir panel de acciones
  openDashboard <- function(){
    shinyjs::removeClass(selector = "body", class = "sidebar-collapse")
    shinyjs::removeClass(selector = "header", class = "hidethis")
    shinyjs::addClass(selector = "header", class = "showthis")
    output$menu <- renderMenu({
      sidebarMenu(id="menu"
                  , if (menu$gerencia$active) {
                    menuItem(menu$gerencia$name, tabName = menu$gerencia$tab, icon = icon(menu$gerencia$icon))
                  }
                  , if (menu$funnel$active) {
                    menuItem(menu$funnel$name, tabName = menu$funnel$tab, icon = icon(menu$funnel$icon))
                  }
                  , if (menu$finanzas$active) {
                    menuItem(menu$finanzas$name, tabName = menu$finanzas$tab, icon = icon(menu$finanzas$icon))
                  }
                  , if (menu$operaciones$active) {
                    menuItem(menu$operaciones$name, tabName = menu$operaciones$tab, icon = icon(menu$operaciones$icon))
                  }
                  , if (menu$mercadeo$active) {
                    menuItem(menu$mercadeo$name, tabName = menu$mercadeo$tab, icon = icon(menu$mercadeo$icon))
                  }
                  , if (menu$talento$active) {
                    menuItem(menu$talento$name, tabName = menu$talento$tab, icon = icon(menu$talento$icon))
                  }
                  , if (menu$novedades$active) {
                    menuItem(menu$novedades$name, tabName = menu$novedades$tab, icon = icon(menu$novedades$icon))
                  }
                  , if (menu$metas$active) {
                    menuItem(menu$metas$name, tabName = menu$metas$tab, icon = icon(menu$metas$icon))
                  }
      )
    })
    output$navtabs <- renderUI({
      if(menu$gerencia$active){callModule(gerencia, "gerencia")}
      if(menu$funnel$active){callModule(funnel, "funnel")}
      if(menu$finanzas$active){callModule(finanzas, "finanzas")}
      if(menu$operaciones$active){callModule(operaciones, "operaciones")}
      if(menu$mercadeo$active){callModule(mercadeo, "mercadeo")}
      if(menu$talento$active){callModule(talento, "talento")}
      if(menu$novedades$active){callModule(novedades, "novedades")}
      if(menu$metas$active){callModule(metas, "metas")}
      
      tabItems(
        tabItem(tabName = "tab_gerencia", if (menu$gerencia$active) gerenciaUI('gerencia'))
        , tabItem(tabName = "tab_funnel", if (menu$funnel$active) funnelUI("funnel"))
        , tabItem(tabName = "tab_finanzas", if (menu$finanzas$active) finanzasUI("finanzas"))
        , tabItem(tabName = "tab_operaciones", if (menu$operaciones$active) operacionesUI("operaciones"))
        , tabItem(tabName = "tab_mercadeo", if (menu$mercadeo$active) mercadeoUI("mercadeo"))
        , tabItem(tabName = "tab_talento", if (menu$talento$active) talentoUI("talento"))
        , tabItem(tabName = "tab_novedades", if (menu$novedades$active) novedadesUI("novedades"))
        , tabItem(tabName = "tab_metas", if (menu$metas$active) metasUI("metas"))
      )
    })
    # Si se pasa un tab de entrada, una ves la página quede cargada, carga ese tab. si no se pasa, carga el de gerencia por default
    query <- parseQueryString(session$clientData$url_search)
    if("page" %in% names(query)){
      isolate(updateTabItems(session, "tabs", query$page))
    } else {
      isolate(updateTabItems(session, "tabs", parameters$tab))
    }
  }
  

  # ---- Cargue de la página de Login ----
  
  # Este observe se activa cuando el botón de Conectar recibe un click. 
  # Inician la animación del archivo ajax-loader-bar.gif hasta que se cambie de ui. 
  # El ui se cambia apenas se confirma el usuario y contraseña.
  # Taken from https://github.com/daattali/advanced-shiny/blob/master/busy-indicator/app.R

  
  # ----- Llamado de los módulos ----- 
  # ----- Manejo del Historial de Navegación -----
  # Taken from https://github.com/daattali/advanced-shiny/blob/master/navigate-history/app.R
  
  # # Change the Shiny app's state based on the URL and page parameter
  # restore <- function(qs) {
  #   data <- parseQueryString(qs)
  #   
  #   if (!is.null(data[['page']])) {
  #     # we're about to change tabs programatically, so don't trigger the
  #     # navigation function
  #     values$autoNavigating <- values$autoNavigating + 1
  #     # change to the correct tab
  #     updateTabItems(session, "tabs", data[['page']])
  #   }
  # }
  # 
  # values <- reactiveValues(
  #   # variable to keep track of whether or not the tab switching is manual (by the
  #   # user) or automatic (restoring the app's state on initialization or prev/next buttons)    
  #   autoNavigating = 0
  # )
  
  # # when the user changes tabs, save the state in the URL
  # observeEvent(input$tabs, {
  #   if (values$autoNavigating > 0) {
  #     values$autoNavigating <- values$autoNavigating - 1
  #     return()
  #   }
  #   # Llama la función encargada de cambiar el URL
  #   shinyjs::js$updateHistory(page = input$tabs)
  # })
  
  # # when the user clicks prev/next buttons in the browser, restore the state
  # observeEvent(input$navigatedTo, {
  #   print(input$navigatedTo)
  #   restore(input$navigatedTo)
  # })
  
  #Creates dynamic notification menu that is as long as the filter data frame notifcationData, with text given by the text parameter in notificationItem
  output$notificationMenu <- renderMenu({
    # Code to generate each of the messageItems here, in a list. This assumes
    # that messageData is a data frame with two columns, 'from' and 'message'.
    
    od <- as.data.table(pool::dbGetQuery(
      ikonocrm
      , parameters$crm_query_op_desactualizadas
    ))
    if(parameters$demostration){
      od <- convert2Demo(od)
    }
    
    ntfs <- apply(od, 1, function(row) {
      notificationItem(text = tags$div(
        "La oportunidad de " 
        # "row["Fecha_Modificacion"], "sin cambios."
        , tags$br()
        , paste(row[["Vendedor"]],"con ", row[["OID"]], "lleva ")
        , tags$br()
        , paste(row[["Dias"]], " días sin cambios.")
        , style = "display: inline-block; vertical-align: middle;"
      ))
    })
    dropdownMenuCustom(
      type = "notifications",
      customSentence = customSentence,
      .list = ntfs)
  })
  
  
  # # ---- Print on console all client data ----
  # observeEvent(session$clientData, {
  #   cdata <- session$clientData
  #   cnames <- names(cdata)
  # 
  #   allvalues <- lapply(cnames, function(name) {
  #     paste(name, cdata[[name]], sep=" = ")
  #   })
  #   cat(paste(allvalues, collapse = "\n"))
  # })
  
  # ---- Stop shiny app when browser tab is closed ---- 
  session$onSessionEnded(stopApp)
  options(shiny.sanitize.errors = TRUE)
}