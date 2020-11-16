crm_filtrosUI <- function(id){
  ns <- NS(id)
  print(sprintf("Setting filters UI - %s", Sys.time()))  
  # ------ Sales Input ------ 
  cat1_input <- selectCheckboxGroupInput(
    id = ns("cat1_filter")
    , label = sprintf("Choose %s", cats_[1])
    , choices = d[!is.na(cat1_), .N, keyby = cat1_]$cat1_
    , selected = d[!is.na(cat1_), .N, keyby = cat1_]$cat1_
    , status = "danger"
  )
  
  cat2_input <- selectCheckboxGroupInput(
    id = ns("cat2_filter")
    , label = sprintf("Choose %s", cats_[2])
    , choices = d[!is.na(cat2_), .N, keyby = cat2_]$cat2_
    , selected = d[!is.na(cat2_), .N, keyby = cat2_]$cat2_
    , status = "warning"
  )
  
  cat3_input <- selectCheckboxGroupInput(
    id = ns("cat3_filter")
    , label = sprintf("Choose %s", cats_[3])
    , choices = d[!is.na(cat3_), .N, keyby = cat3_]$cat3_
    , selected = d[!is.na(cat3_), .N, keyby = cat3_]$cat3_
    , status = "primary"
  )
  
  date_input <- dateRangeInput(
    inputId = ns("dates")
    , label = "Contract sign date:"
    , start = min(d$date_, na.rm = T)
    , end = max(d$date_, na.rm = T)
    , sep = " - "
  )
  
  tagList(list(""
               , column(width = 4
                        , sidebarPanel(width = 12
                                       , h4("Filters")
                                       , cat1_input
                                       , br()
                                       , cat2_input
                                       , br()
                                       , cat3_input
                                       , br()
                                       , date_input
                        )
               )
  ))
}

crm_filtros <- function(input, output, session){
  # ns <- session$ns
  cat1_module <- callModule(selectCheckboxGroup, "cat1_filter", {
    print(sprintf("Setting cat1_ filters server - %s", Sys.time()))  
    unique(d$cat1_)
  })
  cat2_module <- callModule(selectCheckboxGroup, "cat2_filter", {
    print(sprintf("Setting cat2_ filters server - %s", Sys.time()))  
    unique(d$cat2_)
  })
  cat3_module <- callModule(selectCheckboxGroup, "cat3_filter", {
    print(sprintf("Setting cat3_ filters server - %s", Sys.time()))  
    unique(d$cat3_)
  })
  
  #   return(reactive({
  #       paste0(
  #           " WHERE (Fecha_Facturacion BETWEEN '", input$dates[1], "' AND '", input$dates[2], "')"
  #           , " AND Tipo_Oportunidad IN (", paste0("'", paste(type(), collapse = "','"), "'"), ")"
  #           , " AND Vendedores IN (", paste0("'", paste(sellers(), collapse = "','"), "'"), ")"
  #           , " AND Estado IN (", paste0("'", paste(scenario(), collapse = "','"), "'"), ")"
  #       )
  # }))
  return(reactive({
    # Retorna un booleano reactivo
    print(sprintf("Updating logic() in server - %s", Sys.time()))  
    d[,
      date_ >= input$dates[1] &
      date_ <= input$dates[2] &
      cat1_ %in% cat1_module() &
      cat2_ %in% cat2_module() &
      cat3_ %in% cat3_module()
      ]
  }))
}