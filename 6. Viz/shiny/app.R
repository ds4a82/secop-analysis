# install.packages(c(
#     "data.table"
#     , "shiny"
#     , "shinyjs"
#     , "shinydashboard"
#     , "plotly"
#     , "digest"
#     , "DT"
#     , "readxl"
# ))



# ---- Global Code Execution ----
require(data.table)
require(shinydashboard)
require(shiny)
require(shinyjs)

# Menú
# El módulo que invoque debe hacer match con su respectivo UI. Ej: modulo (server) y moduloUI (UI)
# Input:
#   - Modulo (Server y UI)
#   - Lista con las especificaciones del módulo. El tab debe coincidir con el mismo nombre del módulo
menu <- list(
    list(
        active = TRUE
        , name = "Exploratory"
        , tab = "module1" # Debe existir un módulo con este nombre
        , icon = "wpexplorer"
    )
    , list(
        active = TRUE
        , name = "Geographic"
        , tab = "module2" # Debe existir un módulo con este nombre
        , icon = "map-marked"
    )
    , list(
        active = TRUE
        , name = "Contractual Object"
        , tab = "module3" # Debe existir un módulo con este nombre
        , icon = "file-alt"
    )
    , list(
        active = TRUE
        , name = "Team"
        , tab = "module4" # Debe existir un módulo con este nombre
        , icon = "users"
    )
    , list(
        active = TRUE
        , name = "Docs"
        , tab = "module5" # Debe existir un módulo con este nombre
        , icon = "file-pdf"
    )
    , list(
        active = TRUE
        , name = "Video"
        , tab = "module6" # Debe existir un módulo con este nombre
        , icon = "file-video"
    )
)

parameters <- list(
    ""
    , data_filename = "data/secop.RDS"
    , cats_ = c("Modalidad de Contratación", "Tipo de Contrato", "Departamento")
    , nums_ = c("Valor del Contrato", "Valor Facturado", "Días Adicionados")
    , date_ = "Fecha de Firma"
    , dash_color = "purple"
    , title = "Dashboard"
    , credential = data.table(
        Un = c("usuario")
        , Pd = c("contrasena")
        ) # Contraseña SIN caracteres especiales
    , Logged = T
    , shinyjs = "www/app-shinyjs.js"
    , top_img = 'client.png'
    , bottom_img = 'provider.png'
    , favicon = "favicon.ico"
    , loadergif = "ajax-loader-bar.gif"
    , inputBinding = "passwdInputBinding.js"
    , messageHandler = "message-handler.js"
    , md5 = "md5.js"
)

# Run all R files inside src folder
for (file in list.files(
    c("src")
    , pattern = "\\.(r|R)$"
    , recursive = TRUE
    , full.names = TRUE)) {
        source(file, local = TRUE) 
}

shiny::shinyApp(ui = ui, server = server)

