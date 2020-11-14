# SecopTopics - Cluster analysis application for State Procurement - ENGLISH VERSION

<p align="center">
  <img src="https://raw.githubusercontent.com/ds4a82/secop-analysis/master/6.%20Viz/logo/logo.png" />
</p>
              
## General description

Presenting our project **SECOP TOPICS: GROUPING OF PUBLIC PROCUREMENT ISSUES IN KEY WORDS.**

Public procurement refers to the process by which public authorities, such as government departments or local authorities, purchase work, goods or services from companies. Given that public procurement represents a substantial part of taxpayers' money, governments are expected to carry it out efficiently and with high standards of conduct to ensure high quality service delivery and safeguard the public interest.

In this way, it is important to analyze the platform on which the State Entities must publish the Process Documents, from the planning of the contract to its settlement.


- Below you can consult the following information:
   
   - [Problem](#Problem?)
   - [Sources of Information](#Sources-of-Information)
   - [Solution](#Solution)
   - [Work Flow Chart](#Work-Flow-Chart)
   - [Geographic Analysis](#Geographic-Analysis)
   - [Clusters](#Clusters)
   - [License](#license)
   - [Contact](#contact)

## Problem

Grouping contracts by keywords provides a broader and more realistic view of public procurement, by having a better understanding of the goods or services used by public entities. Therefore, Colombia Buy Efficient would have clearer and more useful information to generate real value and savings in public purchases in the country.

## Sources of Information

[**SECOP - I**](https://www.datos.gov.co/Gastos-Gubernamentales/SECOP-I/xvdy-vvsk) <br />
The information is self-documented by the public entities of the country. Each row in the database corresponds to a contract, there are more than **9 million rows. It has 72 columns** in which each column corresponds to information about the hiring process.

[**SECOP - II**](https://www.datos.gov.co/Gastos-Gubernamentales/SECOP-II-Procesos-de-Contrataci-n/p6dx-8zbt) <br />
The information is self-documented by the public entities of the country. Each row in the database corresponds to a contract, there are more than **527 thousand rows. It has 54 columns** in which each column corresponds to information about the hiring process.

## Solution

We have developed this application to provide a tool to Colombia Buy Efficient and to the general public that allows them to achieve a greater knowledge of the goods and services that public entities are buying. To build the application we follow these steps:

<p align="center">
  <img src="https://raw.githubusercontent.com/ds4a82/secop-analysis/master/6.%20Viz/logo/Solution.png" />
</p>

## Work Flow Chart

In the same way, for the development of the application the following methodology was addressed:

<p align="center">
  <img src="https://raw.githubusercontent.com/ds4a82/secop-analysis/master/6.%20Viz/logo/Flujo.png" />
</p>


## Geographic Analysis 

![](https://raw.githubusercontent.com/ds4a82/secop-analysis/master/6.%20Viz/logo/Secop.gif)

## Clusters

The results of the grouping, it is necessary to make a dimensionality reduction. In this case, the technique to graph and have dimensionality reduction is the TSNE. The first 3 conglomerates with the highest density are shown. Cluster 6 has 65% of all classified data in it. The contracts found in this cluster are those related to audiovisuals, environmental issues and municipalities. Cluster 6 is the densest cluster because it has 65% of the entire data set. This group is related to all contracts on castral information. This group contains various amounts of contracts related to property appraisal at the municipal and departmental level. Group 5, which is the next most dense, has a participation of 9% of the entire data set, contains contracts that are related to monitoring and surveillance in the superintendence of projects, finally the third densest group is 8 with a 6% share of data, this cluster is related to all contracts related to health and the environment.

<p align="center">
  <img src="https://raw.githubusercontent.com/ds4a82/secop-analysis/master/6.%20Viz/logo/Clusters.png" />
</p>

The graphs above show that the most common words are “servicios”, “apoyo” y “prestasi”. For bigrams, the most common word pairs are: “prestaci, servicios” and “servicios, profesionales”. Finally, the most common trigrams in SECOP I are “servicios, apoyo gesti” and “prestaci, servicios, apoyo”. This suggests that some specialized cleaning and manipulation methods would need to be performed on the words in order to better group them.

<p align="center">
  <img src="https://raw.githubusercontent.com/ds4a82/secop-analysis/master/6.%20Viz/logo/WordCloud.png" />
</p>


## License

SecopTopics - Cluster analysis application for State Procurement is published under the MIT Copyleft (c) 2020 Data Science For All 3.0 - Team 82 license

For more information you can consult the [License](https://github.com/ucd-dnp/contexto/blob/master/LICENSE)

## Contact

To contact the Data Scientists Unit (UCD) of **Data Science For All 3.0 - Team 82**, you can do so through:

* [Camilo Cabrera](https://www.linkedin.com/in/camilo-cabrera/)
* [Cindy Ramirez](https://www.linkedin.com/in/cindy-ramirez-restrepo/)
* [Jorge Enciso](https://www.linkedin.com/in/jorge-eduardo-enciso-agudelo-6b01b4116/)
* [Karina Mesa](https://www.linkedin.com/in/karina-mesa-a376aa27/)
* [Pedro Casas](https://www.linkedin.com/in/pedro-nicolas-casas/)
* [Samuel Perez](https://www.linkedin.com/in/samuel-perez-spatial-data-scientist/)
* [Yasmin Moya](ymoyav@unicartagena.edu.co)

 <br />
---------------------------------------------------------------///---------------------------------------------------------------
---------------------------------------------------------------///---------------------------------------------------------------
---------------------------------------------------------------///---------------------------------------------------------------
 <br />


# SecopTopics - Aplicación de análisis de Clusters para la Contratación Estatal - VERSIÓN EN ESPAÑOL

<p align="center">
  <img src="https://raw.githubusercontent.com/ds4a82/secop-analysis/master/6.%20Viz/logo/logo.png" />
</p>
              
## Descripción General

Presentando nuestro proyecto **SECOP TOPICS: AGRUPACIÓN DE TEMAS DE CONTRATACIÓN PÚBLICA EN PALABRAS CLAVE.**

La contratación pública se refiere al proceso mediante el cual las autoridades públicas, como los departamentos gubernamentales o las autoridades locales, compran trabajo, bienes o servicios de las empresas. Dado que la contratación pública representa una parte sustancial del dinero de los contribuyentes, se espera que los gobiernos la lleven a cabo de manera eficiente y con altos estándares de conducta para garantizar una alta calidad en la prestación de servicios y salvaguardar el interés público.

De esta forma, es importante analizar la plataforma en la cual las Entidades Estatales deben publicar los Documentos del Proceso, desde la planeación del contrato hasta su liquidación.


- A continuación podrá consultar la siguiente información:
   
  - [Problema](#Problema?)
  - [Fuentes de Información](#Fuentes-de-Informacii%C3%B3n)
  - [Solución](#Soluci%C3%B3n)
  - [Flujograma de Trabajo](#Flujograma-de-Trabajo)
  - [Análisis Geográfico](#Análisis-Geográfico)
  - [Clusters](#Clusters)
  - [Licencia](#licencia)
  - [Contacto](#contacto)   

## Problema

La agrupación de contratos por palabras clave proporciona una visión más amplia y realista de la contratación pública, al tener una mayor comprensión de los bienes o servicios que utilizan las entidades públicas. Por tanto, Colombia Compra Eficiente tendría información más clara y útil para generar valor real y ahorro en las compras públicas del país.

## Fuentes de Información

[**SECOP - I**](https://www.datos.gov.co/Gastos-Gubernamentales/SECOP-I/xvdy-vvsk) <br />
La información es auto documentada por las entidades públicas del país. Cada fila de la base de datos corresponde a un contrato, hay más de **9 millones de filas. Tiene 72 columnas** en las que cada columna corresponde a información sobre el proceso de contratación.

[**SECOP - II**](https://www.datos.gov.co/Gastos-Gubernamentales/SECOP-II-Procesos-de-Contrataci-n/p6dx-8zbt) <br />
La información es auto documentada por las entidades públicas del país. Cada fila de la base de datos corresponde a un contrato, hay más de **527 mil filas. Tiene 54 columnas** en las que cada columna corresponde a información sobre el proceso de contratación.

## Solución

Hemos desarrollado esta aplicación para brindar una herramienta a Colombia Compra Efficiente y al público en general que les permita lograr un mayor conocimiento de los bienes y servicios que las entidades públicas están comprando. Para construir la aplicación seguimos estos pasos:

<p align="center">
  <img src="https://raw.githubusercontent.com/ds4a82/secop-analysis/master/6.%20Viz/logo/Solution.png" />
</p>

## Flujograma de Trabajo

De esta misma forma, para el desarrollo de la aplicación se abordó la siguiente metodología:

<p align="center">
  <img src="https://raw.githubusercontent.com/ds4a82/secop-analysis/master/6.%20Viz/logo/Flujo.png" />
</p>


## Análisis Geográfico 

![](https://raw.githubusercontent.com/ds4a82/secop-analysis/master/6.%20Viz/logo/Secop.gif)

## Clusters

Los resultados del agrupamiento, es necesario hacer una reducción de dimensionalidad. En este caso, la técnica para graficar y tener reducción de dimensionalidad es la TSNE. Se muestran los 3 primeros conglomerados con mayor densidad. El clúster 6 tiene el 65% de todos los datos clasificados en él. Los contratos que se encuentran en este clúster son los relacionados con audiovisuales, temas ambientales y municipios. El clúster 6 es el clúster más denso porque tiene el 65% de todo el conjunto de datos. Este grupo está relacionado con todos los contratos sobre información castral. Este grupo contiene varias cantidades de contratos relacionados con la evaluación de propiedades a nivel municipal y departamental. El grupo 5 que es el siguiente más denso tiene una participación del 9% de todo el conjunto de datos, contiene contratos que están relacionados con el monitoreo y la vigilancia en la superintendencia de proyectos, finalmente el tercer grupo más denso es el 8 con una participación de 6 % de los datos, este clúster está relacionado con todos los contratos relacionados con la salud y el medio ambiente.

<p align="center">
  <img src="https://raw.githubusercontent.com/ds4a82/secop-analysis/master/6.%20Viz/logo/Clusters.png" />
</p>

Los gráficos anteriores muestran que las palabras más comunes son “servicios”, “apoyo” y “prestasi”. Para los bigramas, los pares de palabras más comunes son: “prestaci, servicios” y “servicios, profesionales”. Finalmente, los trigramas más comunes en SECOP I son “servicios, apoyo gesti” y “prestaci, servicios, apoyo”. Esto sugiere que sería necesario realizar algunos métodos especializados de limpieza y manipulación sobre las palabras para poder agruparlas mejor.


<p align="center">
  <img src="https://raw.githubusercontent.com/ds4a82/secop-analysis/master/6.%20Viz/logo/WordCloud.png" />
</p>


## Licencia

SecopTopics - Aplicación de análisis de Clusters para la Contratación Estatal se encuentra publicada bajo la licencia MIT Copyleft (c) 2020 Data Science For All 3.0 - Team 82

Para mayor información puede consultar el archivo de [Licencia](https://github.com/ucd-dnp/contexto/blob/master/LICENSE)

## Contacto

Para comunicarse con la Unidad de Científicos de Datos (UCD) de **Data Science For All 3.0 - Team 82**, lo puede hacer mediante 

* [Camilo Cabrera](https://www.linkedin.com/in/camilo-cabrera/)
* [Cindy Ramirez](https://www.linkedin.com/in/cindy-ramirez-restrepo/)
* [Jorge Enciso](https://www.linkedin.com/in/jorge-eduardo-enciso-agudelo-6b01b4116/)
* [Karina Mesa](https://www.linkedin.com/in/karina-mesa-a376aa27/)
* [Pedro Casas](https://www.linkedin.com/in/pedro-nicolas-casas/)
* [Samuel Perez](https://www.linkedin.com/in/samuel-perez-spatial-data-scientist/)
* [Yasmin Moya](ymoyav@unicartagena.edu.co)

