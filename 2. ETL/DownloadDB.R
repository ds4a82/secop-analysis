# loads the PostgreSQL driver
library(RPostgreSQL)
library(data.table)

getDt <- function(query){
  # creates a connection to the postgres database
  con <- dbConnect(
    dbDriver("PostgreSQL")
    , dbname = "db_secop"
    , host = "ds4a-instance.c0wb6thhjklc.us-east-1.rds.amazonaws.com"
    , port = 5432
    , user = "postgres"
    , password = "ds4a#202082"
  )
  d <- data.table(dbGetQuery(con, query))
  RPostgreSQL::dbDisconnect(con)
  d
}
changeColsEncoding <- function(d, encoding_ = "UTF-8"){
  for(colname_ in colnames(d)){
    if(class(d[[colname_]]) == "character"){
      Encoding(d[[colname_]]) <- encoding_
    }
  }
  d  
}

downloadDepartament <- function(folder_ = "2. ETL/departments/"){
  # Download batch of departamentos
  print(sprintf("Reading departments"))
  departamentos <- getDt("SELECT departamento AS Nombre, COUNT(*) AS Contratos FROM secop GROUP BY departamento")
  states_ <- departamentos$nombre
  for(state_ in states_){ # state_ <- states_[5]
    print(sprintf("Downloading %s", state_))
    d <- getDt(sprintf("SELECT * FROM secop WHERE departamento = '%s'", state_))
    d <- changeColsEncoding(d)
    Encoding(state_) <- "UTF-8"
    state_ <- iconv(state_,from="UTF-8",to="ASCII//TRANSLIT")
    state_ <- gsub(pattern = ".", replacement = "", fixed = T, x = state_)
    state_ <- gsub(pattern = ",", replacement = "", fixed = T, x = state_)
    print(sprintf("Storing %s", state_))
    saveRDS(object = d, file = paste0(folder_, state_, ".RDS"))
  }
}

groupDepartaments <- function(folder_destiny = "6. Viz/shiny/data/"){
  # Bind one single database
  d <- data.table()
  for(rds in list.files( # rds <- "3. Database/extract/San Andres, Providencia y Santa Catalina.RDS"
    c(folder_)
    , pattern = "\\.(rds|RDS)$"
    , recursive = TRUE
    , full.names = TRUE)) {
    d <- rbindlist(l = list(d, readRDS(rds)), use.names = T, fill = T)
  }
  saveRDS(object = d, file = sprintf("%s%s", folder_destiny, "secop.RDS"))
  print(sprintf("File stored in %s", folder_destiny))
  
}

# ---- Download a sample of the database ----
cleanDt <- function(d){
  d <- changeColsEncoding(d)
  d[, fecha_de_firma := as.Date(x = fecha_de_firma, format = "%m/%d/%Y")]
  d[, fecha_de_inicio_de_ejecucion := as.Date(x = fecha_de_inicio_de_ejecucion, format = "%m/%d/%Y")]
  d[, fecha_de_fin_de_ejecucion := as.Date(x = fecha_de_fin_de_ejecucion, format = "%m/%d/%Y")]
  d <- d[!is.na(fecha_de_firma) & fecha_de_firma > "2015-01-01"]
  d  
}

rand <- 50000
d_secop_I <- getDt(sprintf("SELECT * FROM secop WHERE fecha_de_firma <> 'NA' AND fecha_de_firma::date >= '2015-01-01' AND fuente = 'SECOP_I' LIMIT %s;", rand, rand))
d_secop_I <- cleanDt(d_secop_I)
d_secop_I[, .(
  .N
  , min(fecha_de_firma, na.rm = T)
  , max(fecha_de_firma, na.rm = T)
  , paste0(sum(round(valor_del_contrato/1000000, 0), na.rm = T), " M")
  ), departamento][order(N, decreasing = T)]

d_secop_II <- getDt(sprintf("SELECT * FROM secop WHERE fecha_de_firma <> 'NA' AND fecha_de_firma::date >= '2015-01-01' AND fuente = 'SECOP_II' LIMIT %s;", rand, rand))
d_secop_II <- cleanDt(d_secop_II)
d_secop_II[, .(
  .N
  , min(fecha_de_firma, na.rm = T)
  , max(fecha_de_firma, na.rm = T)
  , paste0(sum(round(valor_del_contrato/1000000, 0), na.rm = T), " M")
), departamento][order(N, decreasing = T)]

d <- rbind(d_secop_I, d_secop_II)

# Cambiar los nombres de las columnas por nombres estéticamente presentables. 

# Join de los tópicos y clusters
options(scipen = 50)
clusters <- fread(input = "5. Model/Cluster_Consolidado.csv")
d[, id := paste0(`nit_entidad`, ifelse(is.na(`id_contrato`), "nan", `id_contrato`), as.character(`valor_del_contrato`), ".0")]
d <- merge.data.table(x = d, y = clusters[,.(id, Cluster = cluster, `Topic 1` = Topico_0, `Topic 2` = Topico_1, `Topic 3` = Topico_2)], by = "id", all = T)

d[departamento %in% "Distrito Capital de Bogotá", departamento := "Bogotá D.C."]
d[departamento %in% "No Definido", departamento := as.character(NA)]

unique(d$ca)

d$dias_adicionados <- NULL
d$tipodocproveedor <- NULL
d$codigo_de_categoria_principal <- NULL
d$estado_contrato <- NULL
d$orden <- NULL

setnames(x = d, old = "nombre_entidad", new = "Entity name")
setnames(x = d, old = "nit_entidad", new = "NIT")
setnames(x = d, old = "departamento", new = "Department")
setnames(x = d, old = "ciudad", new = "City")
setnames(x = d, old = "id_contrato", new = "Contract ID")
setnames(x = d, old = "descripcion_del_proceso", new = "Contractual Object")
setnames(x = d, old = "tipo_de_contrato", new = "Contract Type")
setnames(x = d, old = "modalidad_de_contratacion", new = "Contract Modality")
setnames(x = d, old = "fecha_de_firma", new = "Sign date")
setnames(x = d, old = "fecha_de_inicio_de_ejecucion", new = "Start execution date")
setnames(x = d, old = "fecha_de_fin_de_ejecucion", new = "End execution date")
setnames(x = d, old = "documento_proveedor", new = "Provider ID")
setnames(x = d, old = "proveedor_adjudicado", new = "Provider")
setnames(x = d, old = "valor_del_contrato", new = "Contract Value")
setnames(x = d, old = "origen_de_los_recursos", new = "Budget origin")

d$id <- NULL
d[, `Contractual Object` := substring(d$`Contractual Object`, 1, 100)]

unique(d$`Contract Type`)
d[`Contract Type` %in% "Prestación de servicios", `Contract Type` := "Prestación de Servicios"]
d[`Contract Type` %in% "Otro Tipo de Contrato", `Contract Type` := "Otro"]
d[`Contract Type` %in% "Suministros", `Contract Type` := "Suministro"]
d[`Contract Type` %in% "Acuerdo Marco de Precios", `Contract Type` := "Acuerdo Marco"]
d[`Contract Type` %in% "Negocio fiduciario", `Contract Type` := "Fiducia"]
d[`Contract Type` %in% c("DecreeLaw092/2017", "No Especificado", "No definido"), `Contract Type` := NA]

# d <- readRDS(file = "6. Viz/shiny/data/secop.RDS")
d[`Topic 1` %in% 1, `Topic` := "01. Servicios Ambientales y de Salud en Villavicencio y Arauca."]
d[`Topic 1` %in% 2, `Topic` := "02. Mantenimiento y respuestos."]
d[`Topic 1` %in% 3, `Topic` := "03. Servicios de Mantenimiento preventivo y construcción."]
d[`Topic 1` %in% 4, `Topic` := "04. Servicios de salud oriente."]
d[`Topic 1` %in% 5, `Topic` := "05. Capacitación y arrendamientos en Sandanter."]
d[`Topic 1` %in% 6, `Topic` := "06. Servicios de Tranporte e instalación."]
d[`Topic 1` %in% 7, `Topic` := "07. Contratos Bogotá - Cauca."]
d[`Topic 1` %in% 8, `Topic` := "08. Servicios de apoyo para niños y niñas."]
d[`Topic 1` %in% 9, `Topic` := "09. Contatos vigilacia en Salud Medellin."]
d[`Topic 1` %in% 10, `Topic` := "10. Servicios de sanidad para fuerzas militares en Ibague."]
d[`Topic 1` %in% 11, `Topic` := "11. Contratos de Educación en regionales del SENA."]
d[`Topic 1` %in% 12, `Topic` := "12. Vivienda en el departamento de Santander."]
d[`Topic 1` %in% 13, `Topic` := "13. Prestación de servicios a discapacitados."]
d[`Topic 1` %in% 14, `Topic` := "14. Servicios de impresión Barranquilla/Caldas."]
d[`Topic 1` %in% 15, `Topic` := "15. Servicios médicos y de laboratorio en la policía."]
d[`Topic 1` %in% 16, `Topic` := "16. Almacenamiento digital en Valle del Cauca y Magdalena."]
d[`Topic 1` %in% 17, `Topic` := "17. Manejo de agua y residuos sólidos en la infancia en Valledupar."]
d[`Topic 1` %in% 18, `Topic` := "18. Temas deportivos para niños y niñas de Boyacá."]
d[`Topic 1` %in% 19, `Topic` := "19. Informática en escuelas de Pereira, Santa Rosa y Cartago."]
d[`Topic 1` %in% 20, `Topic` := "20. Agua Potable e Internet para docentes pacientes de covid en Bucaramanga y casanare."]
d[`Topic 1` %in% 21, `Topic` := "21. Mejorar vigilancia para victimas del conflicto en el departamento del Valle."]
d[`Topic 1` %in% 22, `Topic` := "22. Temas deportivos en la infancia, en el departamento del Casanare."]
d[`Topic 1` %in% 23, `Topic` := "23. Mantenimiento rutinario del parque automotor y la malla vial para el departamento del Atlántico."]
d[`Topic 1` %in% 24, `Topic` := "24. Obras de rehabilitación vial comunitaria en Santiago de Cali."]
d[`Topic 1` %in% 25, `Topic` := "25. Laboratorios, aires acondicionados y uniformes para Cartagena."]
d[`Topic 1` %in% 26, `Topic` := "26. Medicos y medicina para batallon del ejercito por temas de Coronavirus."]
d[`Topic 1` %in% 27, `Topic` := "27. Gasolina para motores para desplazamiento de papelería, relacionada con temas culturales."]
d[`Topic 1` %in% 28, `Topic` := "28. Hidrocarburos en Cundinamarca, Chocó, departamento de Nariño y Regional Bolívar."]
d[`Topic 1` %in% 29, `Topic` := "29. Alimentación en hospitales de Montenegro y Chachaguí."]
d[`Topic 1` %in% 30, `Topic` := "30. Mantenimiento de vehículos en Sogamoso."]

# Guardar la variable localmente para posterior manipulación
saveRDS(object = d, file = "6. Viz/shiny/data/secop.RDS")
write.table(x = d, file = "6. Viz/shiny/data/secop.csv", sep = ",", na = "", row.names = F, fileEncoding = "latin1")
