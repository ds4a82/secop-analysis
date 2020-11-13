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
                 , br()
                 , fluidRow(HTML(text = lda))
                  , htmltools::HTML("
                                  <ul>
                  <li><p>
                  Topic 30:
                  Mantenimiento de vehículos en Sogamoso
                  </p></li>
                  
                  <li><p>
                  Topic 29:
                  Alimentación en hospitales de Montenegro y chachagui
                  </p></li>
                  
                  <li><p>
                  Topic 28:
                  Hidrocarburos en Cundinamarca, Chocó, departamento de Nariño y Regional Bolívar.
                  </p></li>
                  
                  <li><p>
                  Topic 27:
                  Gasolina para motores para desplazamiento de papelería, relacionada con temas culturales.
                  </p></li>
                  
                  <li><p>
                  Topic 26:
                  Medicos y medicina para batallon del ejercito por temas de coronavirus
                  </p></li>
                  
                  <li><p>
                  Topic 25:
                  Laboratorios, aires acondicionados y uniformes para cartagena
                  </p></li>
                  
                  <li><p>
                  Topic 24:
                  Obras de rehabilitación vial comunitaria en Santiago de Cali
                  </p></li>
                  
                  <li><p>
                  Topic 23:
                  Mantenimiento rutinario del parque automotor y la malla vial para el departamento del Atlántico.
                  </p></li>
                  
                  <li><p>
                  Topic 22:
                  Temas deportivos en la infancia, en el departamento del Casanare
                  </p></li>
                  
                  <li><p>
                  Topic 21:
                  Mejorar vigilancia para victimas del conflicto en el departamento del Valle
                  </p></li>
                  
                  <li><p>
                  Topic 20:
                  Agua Potable e Internet para docentes pacientes de covid en Bucaramanga y casanare
                  </p></li>
                  
                  <li><p>
                  Topic 19:
                  Informática en escuelas de Pereira, Santa Rosa y Cartago.
                  </p></li>
                  
                  <li><p>
                  Topic 18:
                  Temas deportivos para niños y niñas de Boyacá
                  </p></li>
                  
                  <li><p>
                  Topic 17:
                  Manejo de agua y residuos sólidos en la infancia en Valledupar
                  </p></li>
                  
                  <li><p>
                  Topic 16:
                  Almacenamiento digital en Valle del Cauca y Magdalena
                  </p></li>
                  </ul>
                  ")
               )
  )
  tagList(main)
  # mainPanel(width = 12, main)
}

module4 <- function(input, output, session){
  
}