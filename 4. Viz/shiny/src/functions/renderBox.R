renderBox <- function(title, icon, color, data){
  renderValueBox({ valueBox(
    value = tags$p(title, style = "font-size: 60%;")
    , subtitle = tags$p(data(), style = "font-size: 135%;")
    , icon = icon(icon)
    , color = color
  )})    
}

