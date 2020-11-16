module3UI <- function(id){
  print("Initiating Module 3 UI...")
  ns <- NS(id)
  
  main <- list(""
               , HTML('<iframe width="100%" height="900" src="https://app.powerbi.com/view?r=eyJrIjoiZTAzYjY3OTUtNzc4Ni00MDcwLWIxNGYtOTM0OWI1YzMzNWIwIiwidCI6IjU3N2ZjMWQ4LTA5MjItNDU4ZS04N2JmLWVjNGY0NTVlYjYwMCIsImMiOjR9" frameborder="0" allowFullScreen="true"></iframe>')
  )
  tagList(main)
  
}

module3 <- function(input, output, session){

}
