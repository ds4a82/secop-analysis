require(plotly)
module1UI <- function(id){
  ns <- NS(id)
  
  main <- list(""
               , br()
               , wellPanel(style = "background: #c2c0d1",
                 h1("Context")
                 , img(src = "https://github.com/ds4a82/secop-analysis/blob/master/6.%20Viz/shiny/img/Context.png?raw=true", style="width:400px;height:280px;float:right")
                 , fluidRow(p(HTML(paste("Public procurement in Colombia is carried out by State entities that purchase goods and services necessary for its operation. The details of the contracts must be registered in the Electronic System for Public Procurement (SECOP). Until October 2020, contracts for more than ", strong("COP 20.3 billion"), "have been signed through the transactional platform",  strong("SECOP II"), ". This significant amount of resources is supervised by Colombia Compra Eficiente, the public procurement agency that develops and promotes public policies in order to achieve greater efficiency, transparency and optimization of public money.")), style="font-size:20px;margin-left:20px;margin-top:30px"))
               )
               , br()
               , wellPanel(
                 h1("Problem")
                 , img(src = "https://github.com/ds4a82/secop-analysis/blob/master/6.%20Viz/shiny/img/Problem.png?raw=true", style="float:left;")
                 , fluidRow(p(HTML(paste("Due to the large number of contracts registered on the SECOP platforms", strong("(+10 million)"), ", Colombia Compra Eficiente requires to group contracts by identifying common words in the contractual object to generate insights, optimize the public procurement process, and finally help public entities to improve purchasing. However, this grouping is done manually, involving time and effort that could be used in more relevant activities.")), style="font-size:20px;margin-left:20px;margin-top:30px;margin-right:20px"))
               )
               , br()
               , wellPanel(style = "background: #c2c0d1",
                 h1("Solution")
                 , fluidRow(p("We have developed this application to provide a tool to Colombia Compra Efficient and the general public that allows them to achieve a greater understanding of the goods and services that public entities are buying. To build the app we followed these steps:", style="font-size:20px;margin-left:20px;margin-top:20px;margin-right:20px")
                 , br()
                 , img(src = "https://github.com/ds4a82/secop-analysis/blob/master/6.%20Viz/shiny/img/Diagram.png?raw=true", style="width:800px;height:400px;display:block;margin-left:auto;margin-right:auto;")
               ))
               , br()
  )
  tagList(main)
}

module1 <- function(input, output, session){
  # callModule(lineas, "lineas")

}