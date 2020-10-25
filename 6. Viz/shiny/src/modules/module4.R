module4UI <- function(id){
  ns <- NS(id)
  main <- list(""
     , fluidRow(
       ""
       , column(wellPanel(
        h2("Camilo Cabrera, MSc")
        , p("Data Science Consultant at fidelio.com.co")
        , a(icon(name = "envelope"), href = "ccabrera@fidelio.com.co")
        , a(icon(name = "linkedin"), href = "https://www.linkedin.com/in/camilo-cabrera/")
       ), width = 4)
       , column(wellPanel(
        h2("Cindy Ramirez")
        , p("Industrial Engineer working at Rappi")
        , a(icon(name = "envelope"), href = "cindylrr@gmail.com")
        , a(icon(name = "linkedin"), href = "https://www.linkedin.com/in/cindy-ramirez-restrepo")
       ), width = 4)
       , column(wellPanel(
        h2("Jorge Enciso")
        , p("Business Intelligence Analyst working at RobinFood.")
        , a(icon(name = "envelope"), href = "jorgeeduardo.enciso@gmail.com")
        , a(icon(name = "linkedin"), href = "https://www.linkedin.com/in/jorge-eduardo-enciso-agudelo-6b01b4116/")
       ), width = 4)
     )
     , fluidRow(
       ""
       , column(wellPanel(
        h2("Karina Mesa")
        , p("Business Analytics Lead. Financial Services Industry")
        , a(icon(name = "envelope"), href = "karinamesa@gmail.com")
        , a(icon(name = "linkedin"), href = "https://www.linkedin.com/in/karina-mesa-a376aa27/?lipi=urn%3Ali%3Apage%3Ad_flagship3_feed%3Bw5kaMvFCQAiGWNSGXWCpNA%3D%3D")
       ), width = 4)
       , column(wellPanel(
        h2("Nicolas Casas")
        , p("Lorem Ipsum is simply dummy text of the printing and typesetting industry")
        , a(icon(name = "envelope"), href = "")
        , a(icon(name = "linkedin"), href = "")
       ), width = 4)
       , column(wellPanel(
        h2("Samuel Perez")
        , p("Cadastral Engineer and Geodest & Economist Professional. DataViz & TIC Researcher.")
        , a(icon(name = "envelope"), href = "saaperezca@unal.edu.co")
        , a(icon(name = "linkedin"), href = "https://www.linkedin.com/in/samuel-perez-spatial-data-scientist/")
       ), width = 4)
     )
     , fluidRow(
       ""
       , column(width = 4)
       , column(wellPanel(
        h2("Yasmin Moya Villa, MSc")
        , p("Associate Professor at the University of Cartagena")
        , a(icon(name = "envelope"), href = "ymoyav@unicartagena.edu.co")
        , a(icon(name = "linkedin"), href = "www.linkedin.com/in/yasmin-moya-villa")
       ), width = 4)
       , column(width = 4)
     )
  )
  tagList(main)
  # mainPanel(width = 12, main)
}

module4 <- function(input, output, session){

}