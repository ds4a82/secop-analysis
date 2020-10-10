server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$approvalBox <- renderValueBox({
    valueBox(
      "80%", "Approval", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "yellow"
    )
  })
  
}