
module2UI <- function(id){
  ns <- NS(id)
  # This makes web page load the JS file in the HTML head.
  # The call to singleton ensures it's only included once
  # in a page. It's not strictly necessary in this case, but
  # it's good practice.
  
  main <- list(""
      , HTML('<iframe width="100%" height="900" src="https://app.powerbi.com/view?r=eyJrIjoiZTAzYjY3OTUtNzc4Ni00MDcwLWIxNGYtOTM0OWI1YzMzNWIwIiwidCI6IjU3N2ZjMWQ4LTA5MjItNDU4ZS04N2JmLWVjNGY0NTVlYjYwMCIsImMiOjR9" frameborder="0" allowFullScreen="true"></iframe>')
  )
  tagList(main)
  # mainPanel(width = 12, main)
}

module2 <- function(input, output, session){

}