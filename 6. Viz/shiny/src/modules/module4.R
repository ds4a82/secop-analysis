module4UI <- function(id){
  ns <- NS(id)
  main <- list(""
     , fluidRow(
       ""
       , column(wellPanel(
         img(src = "https://github.com/ds4a82/secop-analysis/raw/master/6.%20Viz/shiny/img/team/camilo_photo.jpg", style="width:100px;height:100px;display:block;margin-left:auto;margin-right:auto;") 
        , h2("Camilo Cabrera, MSc")
        , p("Data Science Consultant at fidelio.com.co")
        , a(icon(name = "envelope"), href = "mailto:ccabrera@fidelio.com.co")
        , a(icon(name = "linkedin"), href = "https://www.linkedin.com/in/camilo-cabrera/")
       ), width = 4)
       , column(wellPanel(
         img(src = "https://github.com/ds4a82/secop-analysis/raw/master/6.%20Viz/shiny/img/team/cindy_photo.jpg", style="width:100px;height:100px;display:block;margin-left:auto;margin-right:auto;")
        , h2("Cindy Ramirez")
        , p("Business Intelligence Senior at Rappi")
        , a(icon(name = "envelope"), href = "mailto:cindylrr@gmail.com")
        , a(icon(name = "linkedin"), href = "https://www.linkedin.com/in/cindy-ramirez-restrepo")
       ), width = 4)
       , column(wellPanel(
         img(src = "https://github.com/ds4a82/secop-analysis/raw/master/6.%20Viz/shiny/img/team/jorge_photo.jpg", style="width:100px;height:100px;display:block;margin-left:auto;margin-right:auto;")
        , h2("Jorge Enciso")
        , p("Business Intelligence Analyst at RobinFood.")
        , a(icon(name = "envelope"), href = "mailto:jorgeeduardo.enciso@gmail.com")
        , a(icon(name = "linkedin"), href = "https://www.linkedin.com/in/jorge-eduardo-enciso-agudelo-6b01b4116/")
       ), width = 4)
     )
     , fluidRow(
       ""
       , column(wellPanel(
         img(src = "https://github.com/ds4a82/secop-analysis/raw/master/6.%20Viz/shiny/img/team/karina_photo.jpg", style="width:100px;height:100px;display:block;margin-left:auto;margin-right:auto;")
        , h2("Karina Mesa")
        , p("Business Analytics Lead. Financial Services Industry")
        , a(icon(name = "envelope"), href = "mailto:karinamesa@gmail.com")
        , a(icon(name = "linkedin"), href = "https://www.linkedin.com/in/karina-mesa-a376aa27/?lipi=urn%3Ali%3Apage%3Ad_flagship3_feed%3Bw5kaMvFCQAiGWNSGXWCpNA%3D%3D")
       ), width = 4)
       , column(wellPanel(
         img(src = "https://github.com/ds4a82/secop-analysis/raw/master/6.%20Viz/shiny/img/team/nicolas_photo.jpg", style="width:100px;height:100px;display:block;margin-left:auto;margin-right:auto;")
        , h2("Nicolas Casas")
        , p("FP&A Specialist at Alianza Fiduciaria")
        , a(icon(name = "envelope"), href = "")
        , a(icon(name = "linkedin"), href = "")
       ), width = 4)
       , column(wellPanel(
         img(src = "https://github.com/ds4a82/secop-analysis/raw/master/6.%20Viz/shiny/img/team/samuel_photo.jpg", style="width:100px;height:100px;display:block;margin-left:auto;margin-right:auto;")
        , h2("Samuel Perez")
        , p("Cadastral Engineer and Geodest & Economist")
        , a(icon(name = "envelope"), href = "mailto:saaperezca@unal.edu.co")
        , a(icon(name = "linkedin"), href = "https://www.linkedin.com/in/samuel-perez-spatial-data-scientist/")
       ), width = 4)
     )
     , fluidRow(
       ""
       , column(width = 4)
       , column(wellPanel(
         img(src = "https://github.com/ds4a82/secop-analysis/raw/master/6.%20Viz/shiny/img/team/yasmin_photo.jpg", style="width:100px;height:100px;display:block;margin-left:auto;margin-right:auto;")
        , h2("Yasmin Moya Villa, MSc")
        , p("PhD Student")
        , a(icon(name = "envelope"), href = "mailto:ymoyav@unicartagena.edu.co")
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