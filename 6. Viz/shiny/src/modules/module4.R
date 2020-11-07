module4UI <- function(id){
  ns <- NS(id)
  main <- list(""
     , fluidRow(
       ""
       , column(wellPanel(
         img(src = "https://github.com/ds4a82/secop-analysis/raw/master/6.%20Viz/shiny/img/team/camilo_photo.jpg", style="width:100px;height:100px;display:block;margin-left:auto;margin-right:auto;") 
        , h2("Camilo Cabrera, MSc", style="text-align:center")
        , p("Data Science Consultant at fidelio.com.co", style="text-align:center")
        , a(icon(name = "envelope"), href = "mailto:ccabrera@fidelio.com.co", style="font-size:36px;")
        , a(icon(name = "linkedin"), href = "https://www.linkedin.com/in/camilo-cabrera/", style="font-size:36px;")
       ), width = 4)
       , column(wellPanel(
         img(src = "https://github.com/ds4a82/secop-analysis/raw/master/6.%20Viz/shiny/img/team/cindy_photo.jpg", style="width:100px;height:100px;display:block;margin-left:auto;margin-right:auto;")
        , h2("Cindy Ramirez", style="text-align:center")
        , p("Business Intelligence Senior at Rappi", style="text-align:center")
        , a(icon(name = "envelope"), href = "mailto:cindylrr@gmail.com", style="font-size:36px;")
        , a(icon(name = "linkedin"), href = "https://www.linkedin.com/in/cindy-ramirez-restrepo", style="font-size:36px;")
       ), width = 4)
       , column(wellPanel(
         img(src = "https://github.com/ds4a82/secop-analysis/raw/master/6.%20Viz/shiny/img/team/jorge_photo.jpg", style="width:100px;height:100px;display:block;margin-left:auto;margin-right:auto;")
        , h2("Jorge Enciso", style="text-align:center")
        , p("Business Intelligence Analyst at RobinFood", style="text-align:center")
        , a(icon(name = "envelope"), href = "mailto:jorgeeduardo.enciso@gmail.com", style="font-size:36px;")
        , a(icon(name = "linkedin"), href = "https://www.linkedin.com/in/jorge-eduardo-enciso-agudelo-6b01b4116/", style="font-size:36px;")
       ), width = 4)
     )
     , fluidRow(
       ""
       , column(wellPanel(
         img(src = "https://github.com/ds4a82/secop-analysis/raw/master/6.%20Viz/shiny/img/team/karina_photo.jpg", style="width:100px;height:100px;display:block;margin-left:auto;margin-right:auto;")
        , h2("Karina Mesa", style="text-align:center")
        , p("Business Analytics Lead. Financial Services Industry", style="text-align:center")
        , a(icon(name = "envelope"), href = "mailto:karinamesa@gmail.com", style="font-size:36px;")
        , a(icon(name = "linkedin"), href = "https://www.linkedin.com/in/karina-mesa-a376aa27/?lipi=urn%3Ali%3Apage%3Ad_flagship3_feed%3Bw5kaMvFCQAiGWNSGXWCpNA%3D%3D", style="font-size:36px;")
       ), width = 4)
       , column(wellPanel(
         img(src = "https://github.com/ds4a82/secop-analysis/raw/master/6.%20Viz/shiny/img/team/nicolas_photo.jpg", style="width:100px;height:100px;display:block;margin-left:auto;margin-right:auto;")
        , h2("Nicolas Casas", style="text-align:center")
        , p("FP&A Specialist at Alianza Fiduciaria", style="text-align:center")
        , a(icon(name = "envelope"), href = "mailto:pncasasp@gmail.com", style="font-size:36px;")
        , a(icon(name = "linkedin"), href = "https://www.linkedin.com/in/pedro-nicolas-casas", style="font-size:36px;")
       ), width = 4)
       , column(wellPanel(
         img(src = "https://github.com/ds4a82/secop-analysis/raw/master/6.%20Viz/shiny/img/team/samuel_photo.jpg", style="width:100px;height:100px;display:block;margin-left:auto;margin-right:auto;")
        , h2("Samuel Perez", style="text-align:center")
        , p("Cadastral Engineer and Geodest & Economist", style="text-align:center")
        , a(icon(name = "envelope"), href = "mailto:saaperezca@unal.edu.co", style="font-size:36px;")
        , a(icon(name = "linkedin"), href = "https://www.linkedin.com/in/samuel-perez-spatial-data-scientist/", style="font-size:36px;")
       ), width = 4)
     )
     , fluidRow(
       ""
       , column(width = 4)
       , column(wellPanel(
         img(src = "https://github.com/ds4a82/secop-analysis/blob/master/6.%20Viz/shiny/img/team/yasmin_photo.jpg?raw=true", style="width:100px;height:100px;display:block;margin-left:auto;margin-right:auto;")
        , h2("Yasmin Moya Villa, MSc", style="text-align:center")
        , p("PhD Student", style="text-align:center")
        , a(icon(name = "envelope"), href = "mailto:ymoyav@unicartagena.edu.co", style="font-size:36px;")
        , a(icon(name = "linkedin"), href = "www.linkedin.com/in/yasmin-moya-villa", style="font-size:36px;")
       ), width = 4)
       , column(width = 4)
     )
  )
  tagList(main)
  # mainPanel(width = 12, main)
}

module4 <- function(input, output, session){

}