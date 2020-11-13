module4UI <- function(id){
  ns <- NS(id)
  lda <- paste(readLines("./www/pyLDAvis.html"), collapse="\n")
  clusters <- paste(readLines("./www/KMeansGraph.html"), collapse="\n")
  
  main <- list(""
               , br()
               , wellPanel(
                 h1("Clusters")
                 , fluidRow(p("The results of the clustering, it is needed to make a reduction of dimensionality. In this case, the technique to graph and have reduction of dimensionality is the TSNE.it is shown the top 3 clusters with the highest density. The cluster 6 has 65 % of all the data classified in it. The contracts that are in this cluster are the ones that are related to audiovisuals, environment issues and municipalities.The cluster 6 is  the most dense cluster because it have the 65% of all the dataset. This group is related to all contracts about castral information. This cluster contains several amount of contracts related to evaluation of properties at municipal and departmental level. The cluster 5 that is the next most dense have a share of 9% of all the dataset, it contains contracts that are related to monitoring and surveillance in the superintendence of projects, finally the third most dense cluster is the 8 with a share of 6% of the data, this cluster is related to all the contracts related to health and environment."))
                 , br()
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

module4 <- function(input, output, session){
  
}