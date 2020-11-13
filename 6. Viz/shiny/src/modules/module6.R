module6UI <- function(id){
  ns <- NS(id)
  main <- list(""
    , br()
    , h1("Video presentation")
    , br()
    # Video
    , fluidRow(
       ""
       , column(
         HTML('<div style="overflow:hidden;position: relative;"><iframe frameborder="0" scrolling="no" marginheight="0" marginwidth="0"width="100%" height="400px" type="text/html" src="https://www.youtube.com/embed/v_3NCu6v4ew?autoplay=0&fs=1&iv_load_policy=3&showinfo=0&rel=0&cc_load_policy=0&start=0&end=0"></iframe><div style="position: absolute;bottom: 10px;left: 0;right: 0;margin-left: auto;margin-right: auto;color: #000;text-align: center;"><small style="line-height: 1.8;font-size: 0px;background: #fff;"> <a href="https://deloge.de/" rel="nofollow">Deloge</a> </small></div><style>.newst{position:relative;text-align:right;height:900px;width:100%;} #gmap_canvas img{max-width:none!important;background:none!important}</style></div><br />')
         , width = 12
        )
     )
    , br()
    , h1("Team")
    , br()
    # Team
    , fluidRow(
      ""
      , column(wellPanel(style = "background: #171738",
        img(src = "https://github.com/ds4a82/secop-analysis/raw/master/6.%20Viz/shiny/img/team/camilo_photo.jpg", style="width:150px;height:150px;display:block;margin-left:auto;margin-right:auto;border-radius:75px;border:4px solid #fcfcfc;") 
        , h2("Camilo Cabrera, MSc", style="color:white;text-align:center")
        , p("Data Science Consultant at fidelio.com.co", style="color:white;text-align:center")
        , fluidRow(style = "text-align: center;"
          , a(
            icon(name = "envelope", "fa-3x")
            , href = "mailto:ccabrera@fidelio.com.co"
            , style="padding:1em;text-align: center;display:inline-block;text-decoration: none !important;margin:0 auto;"
            )
          , a(
            icon(name = "linkedin", "fa-3x")
            , href = "https://www.linkedin.com/in/camilo-cabrera/"
            , style="padding:1em;text-align: center;display:inline-block;text-decoration: none !important;margin:0 auto;"
            )
        )
      ), width = 4)
      , column(wellPanel(style = "background: #171738",
        img(src = "https://github.com/ds4a82/secop-analysis/raw/master/6.%20Viz/shiny/img/team/cindy_photo.jpg", style="width:150px;height:150px;display:block;margin-left:auto;margin-right:auto;border-radius:75px;border:4px solid #fcfcfc;")
        , h2("Cindy Ramirez", style="color:white;text-align:center")
        , p("Business Intelligence Senior at Rappi", style="color:white;text-align:center")
        , fluidRow(style = "text-align: center;"
          , a(
            icon(name = "envelope", "fa-3x"), href = "mailto:cindylrr@gmail.com"
            , style="padding:1em;text-align: center;display:inline-block;text-decoration: none !important;margin:0 auto;"
            )
          , a(
            icon(name = "linkedin", "fa-3x"), href = "https://www.linkedin.com/in/cindy-ramirez-restrepo"
            , style="padding:1em;text-align: center;display:inline-block;text-decoration: none !important;margin:0 auto;"
            )
        )
      ), width = 4)
      , column(wellPanel(style = "background: #171738",
        img(src = "https://github.com/ds4a82/secop-analysis/raw/master/6.%20Viz/shiny/img/team/jorge_photo.jpg", style="width:150px;height:150px;display:block;margin-left:auto;margin-right:auto;border-radius:75px;border:4px solid #fcfcfc;")
        , h2("Jorge Enciso", style="color:white;text-align:center")
        , p("Business Intelligence Analyst at RobinFood", style="color:white;text-align:center")
        , fluidRow(style = "text-align: center;"
        , a(icon(name = "envelope", "fa-3x"), href = "mailto:jorgeeduardo.enciso@gmail.com"
            , style="padding:1em;text-align: center;display:inline-block;text-decoration: none !important;margin:0 auto;"
            )
        , a(icon(name = "linkedin", "fa-3x"), href = "https://www.linkedin.com/in/jorge-eduardo-enciso-agudelo-6b01b4116/"
            , style="padding:1em;text-align: center;display:inline-block;text-decoration: none !important;margin:0 auto;"
            )
        )
      ), width = 4)
    )
    , fluidRow(
      ""
      , column(wellPanel(style = "background: #171738",
        img(src = "https://github.com/ds4a82/secop-analysis/raw/master/6.%20Viz/shiny/img/team/karina_photo.jpg", style="width:150px;height:150px;display:block;margin-left:auto;margin-right:auto;border-radius:75px;border:4px solid #fcfcfc;")
        , h2("Karina Mesa", style="color:white;text-align:center")
        , p("Business Analytics Lead. Financial Services Industry", style="color:white;text-align:center")
        , fluidRow(style = "text-align: center;"
                   , a(icon(name = "envelope", "fa-3x"), href = "mailto:karinamesa@gmail.com"
            , style="padding:1em;text-align: center;display:inline-block;text-decoration: none !important;margin:0 auto;"
            )
        , a(icon(name = "linkedin", "fa-3x"), href = "https://www.linkedin.com/in/karina-mesa-a376aa27/?lipi=urn%3Ali%3Apage%3Ad_flagship3_feed%3Bw5kaMvFCQAiGWNSGXWCpNA%3D%3D"
            , style="padding:1em;text-align: center;display:inline-block;text-decoration: none !important;margin:0 auto;"
            )
        )
      ), width = 4)
      , column(wellPanel(style = "background: #171738",
        img(src = "https://github.com/ds4a82/secop-analysis/raw/master/6.%20Viz/shiny/img/team/nicolas_photo.jpg", style="width:150px;height:150px;display:block;margin-left:auto;margin-right:auto;border-radius:75px;border:4px solid #fcfcfc;")
        , h2("Nicolas Casas", style="color:white;text-align:center")
        , p("FP&A Specialist at Alianza Fiduciaria", style="color:white;text-align:center")
        , fluidRow(style = "text-align: center;"
                   , a(icon(name = "envelope", "fa-3x"), href = "mailto:pncasasp@gmail.com"
            , style="padding:1em;text-align: center;display:inline-block;text-decoration: none !important;margin:0 auto;"
            )
        , a(icon(name = "linkedin", "fa-3x"), href = "https://www.linkedin.com/in/pedro-nicolas-casas"
            , style="padding:1em;text-align: center;display:inline-block;text-decoration: none !important;margin:0 auto;"
            )
        )
      ), width = 4)
      , column(wellPanel(style = "background: #171738",
        img(src = "https://github.com/ds4a82/secop-analysis/raw/master/6.%20Viz/shiny/img/team/samuel_photo.jpg", style="width:150px;height:150px;display:block;margin-left:auto;margin-right:auto;border-radius:75px;border:4px solid #fcfcfc;")
        , h2("Samuel Perez", style="color:white;text-align:center")
        , p("Cadastral Engineer and Geodest & Economist", style="color:white;text-align:center")
        , fluidRow(style = "text-align: center;"
                   , a(icon(name = "envelope", "fa-3x"), href = "mailto:saaperezca@unal.edu.co"
            , style="padding:1em;text-align: center;display:inline-block;text-decoration: none !important;margin:0 auto;"
            )
        , a(icon(name = "linkedin", "fa-3x"), href = "https://www.linkedin.com/in/samuel-perez-spatial-data-scientist/"
            , style="padding:1em;text-align: center;display:inline-block;text-decoration: none !important;margin:0 auto;"
            )
        )
      ), width = 4)
    )
    , fluidRow(
      ""
      , column(width = 4)
      , column(wellPanel(style = "background: #171738",
        img(src = "https://github.com/ds4a82/secop-analysis/blob/master/6.%20Viz/shiny/img/team/yasmin_photo.jpg?raw=true", style="width:150px;height:150px;display:block;margin-left:auto;margin-right:auto;border-radius:75px;border:4px solid #fcfcfc;")
        , h2("Yasmin Moya Villa, MSc", style="color:white;text-align:center")
        , p("PhD Student", style="color:white;text-align:center")
        , fluidRow(style = "text-align: center;"
                   , a(icon(name = "envelope", "fa-3x"), href = "mailto:ymoyav@unicartagena.edu.co"
                       , style="padding:1em;text-align: center;display:inline-block;text-decoration: none !important;margin:0 auto;"
                   )
        , a(icon(name = "linkedin", "fa-3x"), href = "www.linkedin.com/in/yasmin-moya-villa"
            , style="padding:1em;text-align: center;display:inline-block;text-decoration: none !important;margin:0 auto;"
            )
        )
      ), width = 4)
      , column(width = 4)
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
  # mainPanel(width = 12, main)
}

module6 <- function(input, output, session){
  
}