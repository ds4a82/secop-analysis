

------------///------------

# SecopTopics - Aplicación de análisis de Clusters para la Contratación Estatal - ESPAÑOL

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
  - [ccumsan](#documentaci%C3%B3n)
  - [Suspendisse](#ejemplo)
  - [tincidunt](#contribuciones)
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

<iframe>
    src="https://app.powerbi.com/view?r=eyJrIjoiZTAzYjY3OTUtNzc4Ni00MDcwLWIxNGYtOTM0OWI1YzMzNWIwIiwidCI6IjU3N2ZjMWQ4LTA5MjItNDU4ZS04N2JmLWVjNGY0NTVlYjYwMCIsImMiOjR9">
</iframe>

![](https://raw.githubusercontent.com/ds4a82/secop-analysis/master/6.%20Viz/logo/Secop.gif)

## Clusters


Los resultados del agrupamiento, es necesario hacer una reducción de dimensionalidad. En este caso, la técnica para graficar y tener reducción de dimensionalidad es la TSNE. Se muestran los 3 primeros conglomerados con mayor densidad. El clúster 6 tiene el 65% de todos los datos clasificados en él. Los contratos que se encuentran en este clúster son los relacionados con audiovisuales, temas ambientales y municipios. El clúster 6 es el clúster más denso porque tiene el 65% de todo el conjunto de datos. Este grupo está relacionado con todos los contratos sobre información castral. Este grupo contiene varias cantidades de contratos relacionados con la evaluación de propiedades a nivel municipal y departamental. El grupo 5 que es el siguiente más denso tiene una participación del 9% de todo el conjunto de datos, contiene contratos que están relacionados con el monitoreo y la vigilancia en la superintendencia de proyectos, finalmente el tercer grupo más denso es el 8 con una participación de 6 % de los datos, este clúster está relacionado con todos los contratos relacionados con la salud y el medio ambiente.

<p align="center">
  <img src="https://raw.githubusercontent.com/ds4a82/secop-analysis/master/6.%20Viz/logo/Flujo.png" />
</p>

Los gráficos anteriores muestran que las palabras más comunes son “servicios”, “apoyo” y “prestasi”. Para los bigramas, los pares de palabras más comunes son: “prestaci, servicios” y “servicios, profesionales”. Finalmente, los trigramas más comunes en SECOP I son “servicios, apoyo gesti” y “prestaci, servicios, apoyo”. Esto sugiere que sería necesario realizar algunos métodos especializados de limpieza y manipulación sobre las palabras para poder agruparlas mejor.


<p align="center">
  <img src="https://raw.githubusercontent.com/ds4a82/secop-analysis/master/6.%20Viz/logo/Flujo.png" />
</p>





```
pip install contexto
```
## Documentación

Nulla facilisi. Fusce quis blandit urna. Nullam ullamcorper purus eu justo fermentum euismod. Curabitur at erat non leo mattis luctus. Nam blandit luctus odio ac dapibus. Ut ex risus, egestas faucibus consectetur in, imperdiet sit amet urna. Donec malesuada commodo libero, sed varius risus malesuada at. 

[Nulla eget purus nec urna elementum tincidunt ut ac mauris.](https://ucd-dnp.github.io/ConTexto/)

## Ejemplo

Nam blandit luctus odio ac dapibus. Ut ex risus, egestas faucibus consectetur in, imperdiet sit amet urna. Donec malesuada commodo libero, sed varius risus malesuada at. Nunc faucibus malesuada venenatis. [sección de ejemplos]( https://ucd-dnp.github.io/ConTexto/seccion_ejemplos.html) de la documentación.

## Contribuciones

Integer fermentum dapibus dictum. In ut dignissim massa. Nulla eget purus nec urna elementum tincidunt ut ac mauris. Donec efficitur sed leo id eleifend. Aliquam placerat congue nisi at pretium. Mauris commodo posuere venenatis. Fusce sollicitudin felis id purus malesuada, eget ultrices risus dignissim. Nam et pretium nisi. Nulla facilisi. Ut convallis sapien auctor ex aliquet, quis pharetra tortor dapibus. Sed non sapien ex. Nullam sit amet orci et odio cursus aliquet.

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

