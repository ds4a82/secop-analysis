require(plotly)
module1UI <- function(id){
  ns <- NS(id)
  
  main <- list(""
               , br()
               , wellPanel(
                 h1("Context")
                 , img(src = "https://github.com/ds4a82/secop-analysis/blob/master/6.%20Viz/shiny/img/Context.png?raw=true", style="width:250px;height:300px;float:right;")
                 , fluidRow(p(HTML(paste("Public procurement in Colombia is carried out by State entities that purchase goods and services necessary for its operation. The details of the contracts must be registered in the Electronic System for Public Procurement (SECOP). Until October 2020, contracts for more than ", strong("COP 20.3 billion"), "have been signed through the transactional platform SECOP II . This significant amount of resources is managed by Colombia Compra Eficiente, the public procurement agency that develops and promotes public policies in order to achieve greater efficiency, transparency and optimization of public money.")), style="font-size:20px;margin-left:25px;margin-top:50px"))
               )
               , br()
               , wellPanel(
                 h1("Problem")
                 , fluidRow(p("Due to the large number of contracts registered on the SECOP platforms (+10 million), Colombia Compra Eficiente requires to group contracts by identifying common words in the contractual object to generate insights, optimize the public procurement process, and finally help public entities to improve purchasing. However, this grouping is done manually, involving time and effort that could be used in more relevant activities.", style="font-size:20px;margin-left:25px;"))
               )
               , br()
               , wellPanel(
                 h1("Solution")
                 , fluidRow(p("We have developed this application to provide a tool to Colombia Compra Efficient and the general public that allows them to achieve a greater understanding of the goods and services that public entities are buying. To build the app we follow this steps:", style="font-size:20px;margin-left:25px;")
                 , img(src = "https://github.com/ds4a82/secop-analysis/blob/master/6.%20Viz/shiny/img/Diagram.png?raw=true", style="width:600px;height:400px;display:block;margin-left:auto;margin-right:auto;")
               ))
               , br()
  )
  tagList(main)
}

module1 <- function(input, output, session){
  # callModule(lineas, "lineas")

}