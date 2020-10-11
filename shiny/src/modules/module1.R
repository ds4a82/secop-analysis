require(plotly)
module1UI <- function(id){
  ns <- NS(id)
  
  insight <- radioButtons(
    # insight <- selectInput(
    inputId = ns("insight")
    , label = h4("Metric")
    , choices = c("Total spent", "Quantity", "Days until done")
    , selected = "Total spent"
    # , inline = TRUE
  )
  bar <- radioButtons(
    # bar <- selectInput(
    inputId = ns("bar")
    , label = h4("Period")
    , choices = c("Weekly", "Monthly", "Quaterly", "Annual")
    , selected = c("Monthly")
    # , selectize = TRUE
    # , inline = TRUE
  )
  perspective <- radioButtons(
    inputId = ns("perspective")
    , label = h4("Perspectiva")
    , choices = c("Type", "State", "Provider"
                  # , "Unidad"
                  , "Cluster")
    , selected = c("Cluster")
    # , inline = TRUE
    # , selectize = TRUE
  )
  main <- list(""
               #### ¡Arreglar estas líneas para volver a colocar!
               # , fluidRow(lineasUI(ns("lineas")))
               , fluidRow(""
                          , crm_filtrosUI(ns("crm_filtros"), estados = c("State 1", "State 2", "State 3"))
                          , column(width = 4
                                   , valueBoxOutput(ns("box1"), width = 12)
                                   , valueBoxOutput(ns("box2"), width = 12)
                                   , valueBoxOutput(ns("box3"), width = 12)
                          )
                          , column(
                            width = 4
                            , valueBoxOutput(ns("box4"), width = 12)
                            , valueBoxOutput(ns("box5"), width = 12)
                            , valueBoxOutput(ns("box6"), width = 12)
                          )
               )
               , fluidRow(
                 box(plotlyOutput(ns("circle"))
                     , box(perspective, title = NULL, footer = NULL, width = 6, height = NULL, status = "primary")
                     , box(insight, title = NULL, footer = NULL, width = 6, height = NULL, status = "primary")
                     , title = "Contratos", footer = NULL, width = 6, height = NULL, status = "primary")
                 , box(plotlyOutput(ns("bar_chart"))
                       , box(bar, title= NULL, footer = NULL, width = 12, height = NULL, status = "primary")
                       , title = "Firmas de contratos", footer = NULL, width = 6, height = NULL, status = "primary")
               )
               , fluidRow(
                 tabBox(id = "gerencia_tabs"
                        , title = 'Tablas'
                        , tabPanel("Contratos"
                                   , p('Contratos:')
                                   , DT::dataTableOutput(ns("oportunidades"))
                        )
                        , tabPanel("Departamentos"
                                   , p('Agrupado de los departamentos:')
                                   , DT::dataTableOutput(ns("clientes"))
                        )
                        , tabPanel("Proveedores"
                                   , p('Agrupado de los proveedores:')
                                   , DT::dataTableOutput(ns("vendedores"))
                        )
                        , width = 12)
               ) 
  )
  tagList(main)
  # mainPanel(width = 12, main)
}

module1 <- function(input, output, session){
  # callModule(lineas, "lineas")
  
  logic <- callModule(crm_filtros, "crm_filtros")
  
  
  # ValueBox 1
  output$box1 <- renderBox("Amount spent ($)", "dollar", "red", reactive({
    # query <- paste0("
    #     SELECT
    #     IFNULL(SUM(`Venta Pond`), 0) as `Venta Pond`
    #     FROM (", parameters$crm_query_op, ") as o"
    #     , logic()
    # )
    # comprss(pool::dbGetQuery(ikonocrm, query))
    comprss(100000)
  }))
  
  # ValueBox 2
  output$box2 <- renderBox("Future contracts", "credit-card", "green", reactive({
    # querybox <- paste0("
    #     SELECT
    #     IFNULL(SUM(`Utilidad Pond`), 0) as `Utilidad Pond`
    #     FROM (", parameters$crm_query_op, ") as o"
    #     , logic()
    # )
    # comprss(pool::dbGetQuery(ikonocrm, querybox))
    comprss(2000000)
  }))
  
  # ValueBox 3. Margen Promedio
  output$box3 <- renderBox("Average money advance", "line-chart", "maroon", reactive({
    # querybox <- paste0("
    #     SELECT
    #     CONCAT(ROUND(100*IFNULL(SUM(`Utilidad Pond`)/SUM(`Venta Pond`), 0), 1), '%') as `Margen Promedio`
    #     FROM (", parameters$crm_query_op, ") as o"
    #     , logic()
    # )
    # pool::dbGetQuery(ikonocrm, querybox)
    comprss(900000)
  }))
  
  # ValueBox 4. Ticket Promedio
  output$box4 <- renderBox("Average value", "fire", "purple", reactive({
    # querybox <- paste0("
    #     SELECT
    #     IFNULL(AVG(`Venta Pond`), 0) as `Venta Pond`
    #     FROM (", parameters$crm_query_op, ") as o"
    #     , logic()
    # )
    # comprss(pool::dbGetQuery(ikonocrm, querybox))
    comprss(40000000)
  }))
  
  # ValueBox 5. DIas promedio en facturar
  output$box5 <- renderBox("Days until done", "flash", "yellow", reactive({
    # querybox <- paste0("
    #     SELECT
    #     IFNULL(ROUND(AVG(`Dias_Facturacion`), 1), 0) as `Dias Facturacion`
    #     FROM (", parameters$crm_query_op, ") as o"
    #     , logic()
    # )
    # pool::dbGetQuery(ikonocrm, querybox)
    88888
  }))
  
  # ValueBox 6. Número de oportunidades
  output$box6 <- renderBox("Contracts", "credit-card", "black", reactive({
    # querybox <- paste0("
    #     SELECT
    #     COUNT(*)
    #     FROM (", parameters$crm_query_op, ") as o"
    #     , logic()
    # )
    # pool::dbGetQuery(ikonocrm, querybox)
    4000
  }))
  
  # PieChart:
  output$circle <- renderPlotly({
    
    amount = 10
    # labels = "Cliente"
    # values = "Venta Pond"
    # logic = ""
    labels = input$perspective
    values = input$insight
    logic = logic()
    
    # # In case there is more labels than 'amount'
    # if(nlevels(droplevels(opportunities[logic][[labels]])) > amount){
    #   if(values %in% "Cantidad"){
    #     h <- head(setorderv(opportunities[logic, .N, by = eval(labels)], c("N"), c(-1)), amount)
    #   } else {
    #     h <- head(setorderv(opportunities[logic, lapply(.SD, sum, na.rm = TRUE), .SDcols = values, by = eval(labels)], c(values), c(-1)), amount)
    #   }
    #   l <- opportunities[[labels]] %in% h[[labels]]
    #   opportunities[l, labels := .SD, .SDcols = labels]
    #   opportunities[!l, labels := "OTROS"]
    #   rm(h, l)
    # } else {
    #   opportunities[, labels := .SD, .SDcols = labels]
    # }
    # 
    
    # query <- paste0("
    #     SELECT
    #     ", labels, " as `labels`
    #     , IFNULL(", ifelse(values == "Cantidad"
    #         , "COUNT(*)"
    #         , paste0("SUM(`", values, "`)")), ", 0) as `values`
    #     , IFNULL(COUNT(*), 0) as Cantidad
    #     , IFNULL(SUM(`Venta Pond`), 0) as `Venta Pond`
    #     , IFNULL(SUM(`Costo Pond`), 0) as `Costo Pond`
    #     , IFNULL(SUM(`Comision Pond`), 0) as `Comision Pond`
    #     , IFNULL(SUM(`Utilidad Pond`), 0) as `Utilidad Pond`
    #     , CONCAT(ROUND(IFNULL(AVG(`Margen`), 0),1),'%') as `margen`
    #     , ROUND(IFNULL(AVG(`Dias_Facturacion`), 0),0) as `cierre`
    #     , CONCAT(ROUND(100*SUM(IF(o.Estado = 'Close', 1, 0))/IFNULL(COUNT(*), 0),1),'%') as `success`
    #     FROM (", parameters$crm_query_op, ") as o "
    #     , logic
    #     , " GROUP BY o.", labels
    #     , " ORDER BY IFNULL(", ifelse(values == "Cantidad"
    #         , "COUNT(*)"
    #         , paste0("SUM(`", values, "`)")), ", 0) DESC"
    #     )
    # data <- data.table(pool::dbGetQuery(ikonocrm, query))
    # write.table(data, "circle.csv", sep = ",", na = "", row.names = FALSE)
    # plot_ly(
    #   data = data
    #   , labels = ~labels
    #   , values = ~values
    #   , type = "pie"
    #   , text = ~paste0(
    #     "Venta (p): ", comprss(`Venta Pond`)
    #     , "<br>Costo (p): ", comprss(`Costo Pond`)
    #     , "<br>Comisión (p): ", comprss(`Comision Pond`)
    #     , "<br>Utilidad (p): ", comprss(`Utilidad Pond`)
    #     , "<br>Margen: ", margen
    #     , "<br>Oportunidades: ", Cantidad
    #     , "<br>Prom. dias en cerrar: ", cierre
    #     , "<br>Success rate: ", success
    #     , "<br>Perspectiva: ", labels
    #   )
    #   , textinfo = "percent" # "label+percent"
    #   , hoverinfo = "label+text+percent"
    #   , showlegend = F
    # ) %>%
    # layout(
    #     yaxis = list(title = "", zeroline = FALSE, showline = FALSE, showticklabels = FALSE, showgrid = FALSE)
    #     , xaxis = list(title = "", zeroline = FALSE, showline = FALSE, showticklabels = FALSE, showgrid = FALSE)
    # )
    dummypieplot <- function(){
      USPersonalExpenditure <- data.frame("Categorie" = rownames(USPersonalExpenditure), USPersonalExpenditure)
      data <- USPersonalExpenditure[, c('Categorie', 'X1960')]
      
      # colors <- c('rgb(211,94,96)', 'rgb(128,133,133)', 'rgb(144,103,167)', 'rgb(171,104,87)', 'rgb(114,147,203)')
      
      fig <- plot_ly(data, labels = ~Categorie, values = ~X1960, type = 'pie',
                     textposition = 'inside',
                     textinfo = 'label+percent',
                     insidetextfont = list(color = '#FFFFFF'),
                     hoverinfo = 'text',
                     text = ~paste('$', X1960, ' billions'),
                     marker = list(line = list(color = '#FFFFFF', width = 1)),
                     #The 'pull' attribute can also be used to create space between the sectors
                     showlegend = FALSE)
      fig <- fig %>% layout(title = '',
                            xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                            yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
      
      fig
    }
    dummypieplot()
  })
  
  # Bar chart for financial forecast
  output$bar_chart <- renderPlotly({
    # timeframe <- "Semanal"
    timeframe <- input$bar
    
    # query <- paste0("SELECT
    # ", timeframe, " as Dates
    #                 , IFNULL(SUM(Venta), 0) as Venta
    #                 , IFNULL(SUM(Utilidad), 0) as Utilidad
    #                 , IFNULL(SUM(Costo), 0) as Costo
    #                 , IFNULL(SUM(Comision), 0) as Comision
    #                 , ROUND(100*IFNULL(SUM(Utilidad)/SUM(Venta), 0), 1) AS Margen
    #                 FROM (SELECT
    #                 `Venta Pond` as 'Venta'
    #                 , `Utilidad Pond` as 'Utilidad'
    #                 , `Costo Pond` as 'Costo'
    #                 , `Comision Pond` as 'Comision'
    #                 , `Fecha_Facturacion` as 'Fecha'
    #                 , DATE_FORMAT(`Fecha_Facturacion`, '%Y') as 'Anual'
    #                 , CONCAT(YEAR(`Fecha_Facturacion`), '-', QUARTER(`Fecha_Facturacion`)) as 'Trimestral'
    #                 , DATE_FORMAT(`Fecha_Facturacion`, '%Y-%m') as 'Mensual'
    #                 , DATE_FORMAT(`Fecha_Facturacion`, '%Y-%v') as 'Semanal'
    #                 FROM (", parameters$crm_query_op, ") as o"
    #                 , logic()
    #                 , ") as q
    #                 GROUP BY ", timeframe
    #                 , " ORDER BY ", timeframe
    #                 )
    # ds <- data.table(pool::dbGetQuery(ikonocrm, query))
    # write.table(ds, "barchart.csv", sep = ",", na = "", row.names = FALSE)
    # plot_ly(
    #   data = ds
    #   , y = ~Utilidad
    #   , x = ~Dates
    #   , name = "Utilidad"
    #   , type = "bar"
    #   , hoverinfo = "none"
    #   , text = ~paste0(
    #     "Venta: ", comprss(Venta)
    #     , "<br>Costo: ", comprss(Costo)
    #     , "<br>Comisiones: ", comprss(Comision)
    #     , "<br>Utilidad: ", comprss(Utilidad)
    #     , "<br>Margen Neto: ", paste0(Margen, "%")
    #     , "<br>Fechas: ", Dates
    #   )
    # ) %>% add_trace(
    #   y = ~Comision
    #   , x = ~Dates
    #   , name = "Comisiones"
    #   , type = "bar"
    #   , hoverinfo = "none"
    # ) %>% add_trace(
    #   y = ~Costo
    #   , x = ~Dates
    #   , type = "bar"
    #   , hoverinfo = "none"
    #   , name = "Costo"
    # ) %>% add_trace(
    #   y = ~(Venta - Utilidad - Comision - Costo)
    #   , x = ~Dates
    #   , type = "bar"
    #   , hoverinfo = "text"
    #   , name = "Cifras"
    # ) %>% add_trace( # Add margin line:
    #   y = ~Margen
    #   , yaxis = "y2"
    #   , type = "scatter"
    #   , mode = "lines"
    #   , hoverinfo = "text"
    #   , text = ~paste0(Margen, "%")
    #   , name = "Margen (%)"
    # ) %>% layout(
    #   xaxis = list(title = "", zeroline = FALSE, showline = FALSE, showticklabels = FALSE, showgrid = FALSE)
    #   , yaxis = list(title = "", zeroline = FALSE, showline = FALSE, showticklabels = TRUE, showgrid = FALSE)
    #   , yaxis2 = list(
    #     tickfont = list(color = "red"),
    #     overlaying = "y",
    #     side = "right"
    #   )
    #   , barmode = "stack"
    #   , showlegend = TRUE
    #   , legend = list(orientation = 'h')
    # )
    dummybarchart <- function(){
      airquality_sept <- airquality[which(airquality$Month == 9),]
      airquality_sept$Date <- as.Date(paste(airquality_sept$Month, airquality_sept$Day, 2019, sep = "."), format = "%m.%d.%Y")
      
      fig <- plot_ly(airquality_sept)
      fig <- fig %>% add_trace(x = ~Date, y = ~Wind, type = 'bar', name = 'Spent',
                               marker = list(color = '#C9EFF9'),
                               hoverinfo = "text",
                               text = ~paste(Wind, ' millions'))
      fig <- fig %>% add_trace(x = ~Date, y = ~Temp, type = 'scatter', mode = 'lines', name = 'Cantidad', yaxis = 'y2',
                               line = list(color = '#45171D'),
                               hoverinfo = "text",
                               text = ~paste(Temp, ' contracts'))
      fig <- fig %>% layout(title = '',
                            xaxis = list(title = ""),
                            yaxis = list(side = 'left', title = 'Spent ($)', showgrid = FALSE, zeroline = FALSE),
                            yaxis2 = list(side = 'right', overlaying = "y", title = 'Quantity', showgrid = FALSE, zeroline = FALSE))
      
      fig
    }
    dummybarchart()
  })
  
  output$oportunidades <- render_tables(
    data = reactive({
      mtcars
        # query <- paste0("SELECT
        # OID
        # , ", ifelse(parameters$demostration
        #         , "Oportunidad"
        #         , "CONCAT('<a href=\"http://crm.ikonosoft.com/ikonosoft/index.php?module=Opportunities&action=DetailView&record=', id, '\" target=\"_blank\">', Oportunidad, '</a>')"
        # ), " as Nombre
        # , Cliente
        # , Tipo_Oportunidad as Tipo
        # , Vendedor
        # , Fecha_Facturacion as `Fecha Fact`
        # , Fecha_Modificacion as `Fecha Mod`
        # , Venta
        # , Utilidad_Neta as Utilidad
        # , CONCAT(Dias_Facturacion, ' días') as Cierre
        # , Margen/100 as Margen
        # , Estado
        # FROM (", parameters$crm_query_op, ") as o
        # ", logic(), "
        # ORDER BY Fecha_Modificacion DESC"
        # )
        # d <- data.table(pool::dbGetQuery(ikonocrm, query))
        # write.table(d, "oportunidades.csv", sep = ",", na = "", row.names = FALSE)
        # if(parameters$demostration){
        #     convert2Demo(d)
        # } else {
        #     d
        # }
    })
    # , currency = c("Venta", "Utilidad")
    # , percentage = c("Margen")
  )
  
  output$vendedores <- render_tables(
    data = reactive({
      iris
        # query <- paste0("SELECT
        #     Vendedor
        #     , COUNT(*) as Cantidad
        #     , IFNULL(SUM(`Venta Pond`), 0) as Venta
        #     , IFNULL(SUM(`Utilidad Pond`), 0) as Utilidad
        #     , IFNULL(SUM(`Comision Pond`), 0) as `Comisión`
        #     , IFNULL(SUM(`Utilidad Pond`)/SUM(`Venta Pond`), 0) as Margen
        #     , CONCAT(ROUND(IFNULL(AVG(Dias_Facturacion), 0), 0), ' dias') as Cierre
        #     FROM (", parameters$crm_query_op, ") as o
        #     ", logic(), "
        #     GROUP BY Vendedor
        #     ORDER BY COUNT(*) DESC"
        # )
        # d <- data.table(pool::dbGetQuery(ikonocrm, query))
        # write.table(d, "vendedores.csv", sep = ",", na = "", row.names = FALSE)
        # if(parameters$demostration){
        #     convert2Demo(d)
        # } else {
        #     d
        # }
    })
    # , currency = c("Venta", "Utilidad", "Comisión")
    # , percentage = c("Margen")
  )
  
  output$clientes <- render_tables(
    data = reactive({
      mtcars
        # query <- paste0("SELECT
        #     Cliente
        #     , Vendedor
        #     , COUNT(*) as Cantidad
        #     , IFNULL(SUM(`Venta Pond`), 0) as Venta
        #     , IFNULL(SUM(`Utilidad Pond`), 0) as Utilidad
        #     , IFNULL(SUM(`Comision Pond`), 0) as Comision
        #     , IFNULL(SUM(`Utilidad Pond`)/SUM(`Venta Pond`), 0) as Margen
        #     , IFNULL(AVG(Dias_Facturacion), 0) as Cierre
        #     FROM (", parameters$crm_query_op, ") as o
        #     ", logic(), "
        #     GROUP BY Cliente, Vendedor
        #     ORDER BY COUNT(*) DESC"
        # )
        # d <- data.table(pool::dbGetQuery(ikonocrm, query))
        # write.table(d, "clientes.csv", sep = ",", na = "", row.names = FALSE)
        # if(parameters$demostration){
        #     convert2Demo(d)
        # } else {
        #     d
        # }
    })
    # , currency = c("Venta", "Utilidad", "Comision")
    # , percentage = c("Margen")
  ) 
}