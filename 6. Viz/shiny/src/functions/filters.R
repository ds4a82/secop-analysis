crm_filtrosUI <- function(id, estados = c("Close")){
  ns <- NS(id)
  
  # ------ Sales Input ------ 
  seller <- selectCheckboxGroupInput(
    id = ns("sellers")
    , label = "Choose provider"
    , choices = {
      # query <- paste0("SELECT
      #     DISTINCT(Vendedores) as V
      #     FROM (", parameters$crm_query_op, ") as o
      # ")
      # pool::dbGetQuery(ikonocrm, query)$V
      paste0("Provider ", 1:10)
    }
    , status = "danger"
  )
  type <- selectCheckboxGroupInput(
    id = ns("type")
    , label = "Choose state"
    , choices = {
      # query <- paste0("SELECT
      #     DISTINCT(Tipo_Oportunidad) as Tipo
      #     FROM (", parameters$crm_query_op, ") as o
      # ")
      # pool::dbGetQuery(ikonocrm, query)$Tipo
      paste0("State ", 1:15)
    }
    , status = "warning"
  )
  scenario <- selectCheckboxGroupInput(
    id = ns("scenario")
    , label = "Choose type"
    , choices = {
      # query <- paste0("SELECT
      #     DISTINCT(Estado) as Estado
      #     FROM (", parameters$crm_query_op, ") as o
      #     ORDER BY CASE
      #     WHEN Estado = 'Close' then 1 
      #     WHEN Estado = 'Won' then 2
      #     WHEN Estado = 'Forecast' then 3
      #     WHEN Estado = 'Upside' then 4
      #     WHEN Estado = 'Pipeline' then 5
      #     WHEN Estado = 'Prospect' then 6
      #     else 7
      #     end
      # ")
      # pool::dbGetQuery(ikonocrm, query)$Estado
      paste0("Type ", 1:3)
      
    }
    , selected = estados
    , status = "primary"
  )
  dates <- dateRangeInput(
    inputId = ns("dates")
    , label = "Contract sign date:"
    , start = "2019-01-01" # First of this month
    , end = "2019-12-31"
    # , start = floor_date(Sys.time(), 'year') # First of this month
    # , end = floor_date(Sys.time(), 'year') + years(1) - days(1)
    , sep = " - "
  )
  tagList(list(""
               , column(width = 4
                        , sidebarPanel(width = 12
                                       , h4("Filters")
                                       , seller
                                       , br()
                                       , type
                                       , br()
                                       , scenario
                                       , br()
                                       , dates
                        )
               )
  ))
}

crm_filtros <- function(input, output, session){
  # ns <- session$ns
  sellers <- callModule(selectCheckboxGroup, "sellers"
                        , {
                          # query <- paste0("SELECT
                          #                 DISTINCT(Vendedores) as V
                          #                 FROM (", parameters$crm_query_op, ") as o
                          #                 ")
                          # pool::dbGetQuery(ikonocrm, query)$V
                          paste("Provider", 1:10)
                        }
  )
  scenario <- callModule(selectCheckboxGroup, "scenario", {
    # query <- paste0("SELECT
    #         DISTINCT(Estado) as Estado
    #         FROM (", parameters$crm_query_op, ") as o
    #         ORDER BY CASE
    #         WHEN Estado = 'Close' then 1 
    #         WHEN Estado = 'Won' then 2
    #         WHEN Estado = 'Forecast' then 3
    #         WHEN Estado = 'Upside' then 4
    #         WHEN Estado = 'Pipeline' then 5
    #         WHEN Estado = 'Prospect' then 6
    #         else 7
    #         end
    #     ")
    # pool::dbGetQuery(ikonocrm, query)$Estado
    paste("State ", 1:15)
    
  })
  type <- callModule(selectCheckboxGroup, "type", {
    # query <- paste0("SELECT
    #                 DISTINCT(Tipo_Oportunidad) as Tipo
    #                 FROM (", parameters$crm_query_op, ") as o
    #                 ")
    # pool::dbGetQuery(ikonocrm, query)$Tipo
    paste("Type ", 1:3)
  })
  
  #   return(reactive({
  #       paste0(
  #           " WHERE (Fecha_Facturacion BETWEEN '", input$dates[1], "' AND '", input$dates[2], "')"
  #           , " AND Tipo_Oportunidad IN (", paste0("'", paste(type(), collapse = "','"), "'"), ")"
  #           , " AND Vendedores IN (", paste0("'", paste(sellers(), collapse = "','"), "'"), ")"
  #           , " AND Estado IN (", paste0("'", paste(scenario(), collapse = "','"), "'"), ")"
  #       )
  # }))
}