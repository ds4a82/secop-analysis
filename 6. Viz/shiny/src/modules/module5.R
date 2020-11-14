module5UI <- function(id){
  ns <- NS(id)
  main <- list(
    ""
    , br()
    , fluidRow(
      column(
        width = 6
        , wellPanel(
         h2("1. Database integration")
         , fluidRow(
           p("Everytime the dashboard runs, it loads a local '.RDS' file containing 100.000 aleatory contracts read from a PostgreSQL database on an AWS server. The next step regarding databases, is to take the dashboards command controls and plug them directly into the database to reduce loading time.")
           , br()
           , p("This approach opens up the opportunity to schedule a dialy, weekly or monthly download of the files in datos.gov.co (contracts main location), process them locally (data cleaning) and upload them into the AWS database. Based on the frecuency of the schedule defined, the dashboard could be updated in real time.")
          )
        )
      )
      , column(
        width = 6
        , wellPanel(
         h2("2. Contracts categorization")
         , fluidRow(
           p("The are several main categories already identified by the Colombia Compra Eficiente (CCE) team. Some of them involve \"health\", \"construction\", \"infraestructure\" and \"technology\" among many others. The next step would be to list the most relevant categories and semi-automatically categorize all the contracts based on the keywords in their description. For example the word \"hospital\" can be matched within the Health category.")
           , br()
           , p("After processing all the categories, Clustering and LDA topic modelling analysis can be re-run into each category to analize their main topics and take decisions regarding national budget spending.")
          )
        )
      )
    )
    , br()
    , h1("White paper", style = "text-align: center;")
    , br()
    # Document
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
}

module5 <- function(input, output, session){

}