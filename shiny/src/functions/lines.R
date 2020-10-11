lineasUI <- function(id){
  ns <- NS(id)
  div(style="text-align:right; width:100%"
      , "Oportunidades creadas (30d)."
      , sparklineOutput(ns("numVentasC"))
      , "Oportunidades facturadas (30d)."
      , sparklineOutput(ns("numVentasF"))
      , "Ventas (30d)."
      , sparklineOutput(ns("valVentas"))
  )
}

lineas <- function(input, output, session){
  output$valVentas <- renderSparkline(
    sparkline(
      #Filtro de Opportunities para que devuelva el valor de las ventas de los últimos tres días
      opportunities[,.(Venta=sum(Venta)), by=Fecha_Facturacion][Sys.Date() - Fecha_Facturacion<30][Sys.Date() - Fecha_Facturacion>0][order(Fecha_Facturacion)][,Venta]
    )
  )
  
  output$numVentasF <- renderSparkline(
    sparkline(
      #Filtro de Opportunities para que devuelva el número de ventas facturadas de los últimos tres días
      opportunities[,.N, by=Fecha_Facturacion][Sys.Date() - Fecha_Facturacion<30][Sys.Date() - Fecha_Facturacion>0][order(Fecha_Facturacion)][,N]
    )
  )
  
  output$numVentasC <- renderSparkline(
    sparkline(
      #Filtro de Opportunities para que devuelva el número de ventas creadas de los últimos tres días
      opportunities[Sys.Date() - Fecha_Facturacion<30][Sys.Date() - Fecha_Facturacion>0][order(Fecha_Facturacion)][,.N, by=Fecha_Creacion][,N])
  )
}
