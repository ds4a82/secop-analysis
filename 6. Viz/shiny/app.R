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
options(encoding = 'UTF-8')
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
        , name = "Home"
        , tab = "module1" # Debe existir un módulo con este nombre
        , icon = "home"
    )
    , list(
        active = TRUE
        , name = "Exploratory"
        , tab = "module2" # Debe existir un módulo con este nombre
        , icon = "wpexplorer"
    )
    , list(
        active = TRUE
        , name = "Geographic"
        , tab = "module3" # Debe existir un módulo con este nombre
        , icon = "map-marked"
    )
    , list(
        active = TRUE
        , name = "Contractual Object"
        , tab = "module4" # Debe existir un módulo con este nombre
        , icon = "file-alt"
    )
    , list(
        active = TRUE
        , name = "Next Steps"
        , tab = "module5" # Debe existir un módulo con este nombre
        , icon = "file-pdf"
    )
    , list(
        active = TRUE
        , name = "Acknowledgment"
        , tab = "module6" # Debe existir un módulo con este nombre
        , icon = "users"
    )
)

parameters <- list(
    ""
    , data_filename = "data/secop.RDS"
    , cats_ = c("Contract Type", "Department", "Topic 1")
    , nums_ = c("Contract Value")
    , date_ = "Sign date" # Must be single.
    , dash_color = "purple"
    , title = 'Secop Topics'
    #, title = img(src = 'https://github.com/ds4a82/secop-analysis/blob/master/6.%20Viz/logo/logo.png?raw=true', width = '150px', height = '50px')
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

shiny::shinyApp(ui = ui, server = server, enableBookmarking = "server")

