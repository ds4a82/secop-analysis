module3UI <- function(id){
  ns <- NS(id)
  
  lda <- paste(readLines("./model/pyLDAvis.html"), collapse="\n")
  clusters <- paste(readLines("./model/KMeansGraphModified.html"), collapse="\n")
  
  main <- list(""
    , wellPanel(
      h1("n-grams analysis")
      , fluidRow(
        column(
          img(src = "https://github.com/ds4a82/secop-analysis/raw/master/1.%20EDA/Secop%202/Grafico%20de%20Frecuencia%20de%202-gram.png", style="width:400px;height:400px;")
          , width = 6
        )
        , column(
          h3("2-grams analysis")
          , p("Top 20 bigrams from the contractual object of SECOP I shows that the bigrams 'prestaci - servicios',  'prestar - servicios', 'prestacion - servicios', 'prestaci - servicio' and  'prestar - servicio' are the most frequent. This may represent that most contracts are related to the provision of services.")
          , width = 6
        )
      )
    )
    
    , br()
    , wellPanel(
      h1("Clusters")
     , fluidRow(HTML(text = clusters))
    )
    , br()
    , wellPanel(
      h1("Topics")
      , p("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).")
      , br()
     , fluidRow(HTML(text = lda))
     )
  )
  tagList(main)
  # mainPanel(width = 12, main)
}

module3 <- function(input, output, session){

}
