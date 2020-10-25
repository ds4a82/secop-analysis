module3UI <- function(id){
  ns <- NS(id)
  
  clustering <- paste(readLines("./www/KMeans_Graph.html"), collapse="\n")
  lda <- paste(readLines("./www/LDA.html"), collapse="\n")
  
  main <- list(""
    , wellPanel(
      h1("Word analysis")
     , fluidRow(
       column(
         img(src = "https://github.com/ds4a82/secop-analysis/raw/master/1.%20EDA/Secop1/SecopI.png", style="width:400px;height:400px;")
         , width = 6
       )
       , column(
         h3("What is Lorem Ipsum?")
         , p("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
         , width = 6
       )
       )
    )
    , br()
    , wellPanel(
      h1("Clustering")
     , fluidRow(
       column(
         img(src = "https://github.com/ds4a82/secop-analysis/raw/master/1.%20EDA/Secop%202/kmeandummy.png", style="width:400px;height:400px;")
         , width = 6
       )
       , column(
         h3("What is Lorem Ipsum?")
         , p("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
         , width = 6
       )
       )
    )
    , br()
    , wellPanel(
      h1("LDA")
      , p("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).")
      , br()
     , fluidRow(HTML(text = lda)
                ))
  )
  tagList(main)
  # mainPanel(width = 12, main)
}

module3 <- function(input, output, session){

}
