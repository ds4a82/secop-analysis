module5UI <- function(id){
  ns <- NS(id)
  main <- list(""
     , br()
     , br()
     , br()
     , fluidRow(
       ""
       , column(width = 2)
       , column(width = 8
                , HTML('<iframe width="100%" height="500" src="https://www.mintic.gov.co/portal/604/articles-145965_recurso_1.pdf" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')
       )
       , column(width = 2)
     )
  )
  tagList(main)
  # mainPanel(width = 12, main)
}

module5 <- function(input, output, session){

}