module5UI <- function(id){
  ns <- NS(id)
  main <- list(""
               , br()
               , wellPanel(
                 h1("Database integration")
                 , fluidRow(
                   p("Everytime the dashboard runs it is loading a local '.RDS' file containing 100.000 aleatory contracts read from a PostgreSQL database on an AWS server. The next step regarding databases, is to take the dashboards command controls and plug them directly into the database to reduce loading time and open the possibility to update the database on a dialy, weekly or monthly basis. ")
                   , br()
                   , p("This approach opens up the opportunity to schedule a dialy, weekly or monthly download of the files in Datos Abiertos (contracts main location), process them locally (data cleaning) and upload them into the AWS database. Based on the frecuency of the schedule, the dashboard could be updated in real time.")
                  )
               )
               , br()
               , wellPanel(
                 h1("Contracts manual categorization")
                 , fluidRow(
                   p("The are several main categories already identified by the Colombia Compra Eficiente (CCE) team. Some of them involve \"health\", \"construction\", \"infraestructure\" and \"technology\" among many others. The next step would be to semi-automatically categorize all the contracts based on the keywords in their description. For example by matching the word \"hospital\" to the Health category. ")
                   , br()
                   , p("After processing all the categories, the Clustering and LDA topic modelling analysis can be zoomed-in into each category to analize their content.")
                  )
               )
               , br()
  )
  tagList(main)
}

module5 <- function(input, output, session){

}