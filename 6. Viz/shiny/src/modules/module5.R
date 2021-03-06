module5UI <- function(id){
  print("Initiating Module 5 UI...")
  ns <- NS(id)
  main <- list(
    ""
    , h2("Next Steps", style = "text-align:center;")
    , fluidRow(
      img(src = "https://github.com/ds4a82/secop-analysis/blob/master/6.%20Viz/shiny/img/next-steps.jpg?raw=true", style="display: block;margin-left: auto;margin-right: auto;width: 50%;")
      )
    , br()
    , p('These are the main steps projected to deploy a real time dashboard designed to deliver insights within each contract category:', style="font-size:20px;text-align:center;")
    , br()
    , fluidRow(
      column(
        width = 6
        , wellPanel(style = "background: #c2c0d1",
         h2("1. Database integration")
         , fluidRow(
           p("Everytime the dashboard runs, it loads a local '.RDS' file containing 100.000 aleatory contracts read from a PostgreSQL database on an AWS server. The next step regarding databases is to take the dashboards command controls and plug them directly into the database to reduce loading time.", style = "font-size:16px;margin-right:20px;margin-left:20px;margin-top:20px")
           , br()
           , p("This approach opens up the opportunity to schedule a dialy, weekly or monthly download of the files in datos.gov.co (contracts main location), process them locally (data cleaning) and upload them into the AWS database. Based on the frecuency of the schedule defined, the dashboard could be updated in real time.", style = "font-size:16px;margin-right:20px;margin-left:20px")
          )
        )
      )
      , column(
        width = 6
        , wellPanel(
         h2("2. Contracts categorization")
         , fluidRow(
           p("The are several main categories already identified by the Colombia Compra Eficiente (CCE) team. Some of them involve \"health\", \"construction\", \"infraestructure\" and \"technology\" among many others. The next step would be to list the most relevant categories and semi-automatically categorize all the contracts based on the keywords in their description. For example the word \"hospital\" can be matched within the Health category.", style = "font-size:16px;margin-right:20px;margin-left:20px;margin-top:20px")
           , br()
           , p("After processing all the categories, Clustering and LDA topic modelling analysis can be re-run into each category to analize their main topics and take decisions regarding national budget spending.", style = "font-size:16px;margin-right:20px;margin-left:20px")
          )
        )
      )
    )
    , br()
  )
  tagList(main)
}

module5 <- function(input, output, session){

}