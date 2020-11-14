module4UI <- function(id){
  ns <- NS(id)
  lda <- paste(readLines("./www/pyLDAvis.html"), collapse="\n")
  clusters <- paste(readLines("./www/KMeansGraph.html"), collapse="\n")
  
  main <- list(""
               , br()
               , wellPanel(
                 h1("Clusters")
                 , fluidRow(
                   column(width = 8, HTML(text = clusters))
                   , column(width = 4, style = "padding-left:60px"
                     , br(), br(), br()
                     , HTML("This is a graphical representation of all contracts available in SECOP. The color represents the natural groups (clusters) formed after mathematical computations. <b>Each cluster contain the contracts on which their description is the closest to each other</b>.")
                     , br()
                     , br()
                     , HTML("The cluster 6 (colored blue) has 65% of all the data classified in it. The contracts that are in this cluster are the ones related to <b>audiovisuals, environment issues, municipalities and castral information</b>. This cluster contains several amount of contracts related to evaluation of properties at municipal and departmental level.")
                     , br()
                     , br()
                     , HTML("The cluster 5 (colored light blue) shares 9% of all contracts. It contains contracts that are related to <b>monitoring and surveillance of the execution of projects.</b>")
                     , br()
                     , br()
                     , HTML("Finally the third most dense cluster is the 8th with a share of 6% of the data, this cluster is related to all the contracts in the <b>health and environmental sector</b>.")
                     , br() 
                     , br() 
                     , HTML("Hover over each point to highlight the contract description's main words")
                  )
                   
                 )
               )
               , br()
               , wellPanel(
                 h1("Topics")
                 , br()
                 , fluidRow(HTML(text = lda))
                  , htmltools::HTML("
                                  <ul>
<li><p>Topic 1: Servicios Ambientales y de Salud en Villavicencio y Arauca.</p></li>

<li><p>Topic 2: Mantenimiento y respuestos.</p></li>

<li><p>Topic 3: Servicios de Mantenimiento preventivo y construcción.</p></li>

<li><p>Topic 4: Servicios de salud oriente.</p></li>

<li><p>Topic 5: Capacitación y arrendamientos en Sandanter.</p></li>

<li><p>Topic 6: Servicios de Tranporte e instalación.</p></li>

<li><p>Topic 7: Contratos Bogotá - Cauca.</p></li>

<li><p>Topic 8: Servicios de apoyo para niños y niñas.</p></li>

<li><p>Topic 9: Contatos vigilacia en Salud Medellin.</p></li>

<li><p>Topic 10: Servicios de sanidad para fuerzas militares en Ibague.</p></li>

<li><p>Topic 11: Contratos de Educación en regionales del SENA.</p></li>

<li><p>Topic 12: Vivienda en el departamento de Santander.</p></li>

<li><p>Topic 13: Prestación de servicios a discapacitados.</p></li>

<li><p>Topic 14: Servicios de impresión Barranquilla/Caldas.</p></li>

<li><p>Topic 15: Servicios médicos y de laboratorio en la policía.</p></li>

<li><p>Topic 16: Almacenamiento digital en Valle del Cauca y Magdalena.</p></li>

<li><p>Topic 17: Manejo de agua y residuos sólidos en la infancia en Valledupar.</p></li>

<li><p>Topic 18: Temas deportivos para niños y niñas de Boyacá.</p></li>

<li><p>Topic 19: Informática en escuelas de Pereira, Santa Rosa y Cartago.</p></li>

<li><p>Topic 20: Agua Potable e Internet para docentes pacientes de covid en Bucaramanga y casanare.</p></li>

<li><p>Topic 21: Mejorar vigilancia para victimas del conflicto en el departamento del Valle.</p></li>

<li><p>Topic 22: Temas deportivos en la infancia, en el departamento del Casanare.</p></li>

<li><p>Topic 23: Mantenimiento rutinario del parque automotor y la malla vial para el departamento del Atlántico.</p></li>

<li><p>Topic 24: Obras de rehabilitación vial comunitaria en Santiago de Cali.</p></li>

<li><p>Topic 25: Laboratorios, aires acondicionados y uniformes para Cartagena.</p></li>

<li><p>Topic 26: Medicos y medicina para batallon del ejercito por temas de Coronavirus.</p></li>

<li><p>Topic 27: Gasolina para motores para desplazamiento de papelería, relacionada con temas culturales.</p></li>

<li><p>Topic 28: Hidrocarburos en Cundinamarca, Chocó, departamento de Nariño y Regional Bolívar.</p></li>

<li><p>Topic 29: Alimentación en hospitales de Montenegro y Chachaguí.</p></li>

<li><p>Topic 30: Mantenimiento de vehículos en Sogamoso.</p></li>

</ul>
                  ")
               )
  )
  tagList(main)
  # mainPanel(width = 12, main)
}

module4 <- function(input, output, session){
  
}