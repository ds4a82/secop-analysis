module5UI <- function(id){
  ns <- NS(id)
  main <- list(""
     , br()
     , br()
     , br()
     , fluidRow(
       ""
       , column(width = 2)
       , column(width = 8)
       , column(width = 2)
     )
  )
  tagList(main)
  # mainPanel(width = 12, main)
}

module5 <- function(input, output, session){

}