require(plotly)
module1UI <- function(id){
  ns <- NS(id)
  
  main <- list(""
               , br()
               , wellPanel(
                 h1("Context")
                 , fluidRow(p("Public procurement in Colombia is carried out by State entities that purchase goods and services necessary for its operation. The details of the contracts must be registered in the Electronic System for Public Procurement (SECOP). Until October 2020, in Colombia contracts for more than COP 20.3 billion have been signed through the transactional platform SECOP II . This significant amount of resources is managed by Colombia Compra Eficiente, the public procurement agency that develops and promotes public policies in order to achieve greater efficiency, transparency and optimization of public money."))
               )
               , br()
               , wellPanel(
                 h1("Problem")
                 , fluidRow(p("Due to the large number of contracts registered on the SECOP platforms, Colombia Compra Eficiente requires group contracts that are related by identifying common words in the contractual object to generate insights, optimize the public procurement process, and finally help public entities to improve purchasing. However, this grouping is done manually, involving time and effort that could be used in more relevant activities."))
               )
               , br()
               , wellPanel(
                 h1("Solution")
                 , fluidRow(p("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."))
               )
               , br()
               , wellPanel(
                 h1("Methodology")
                 , fluidRow(p("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."))
               )
               , br()
  )
  tagList(main)
}

module1 <- function(input, output, session){
  # callModule(lineas, "lineas")

}