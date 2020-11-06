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
  d  
}


rand <- 1000
d <- getDt(sprintf("SELECT * FROM secop OFFSET floor(random()*%s) WHERE fecha_de_firma <> 'NA' AND fecha_de_firma::date >= '2015-01-01' LIMIT %s;", rand, rand))
d <- cleanDt(d)
d[, .(
  .N
  , min(fecha_de_firma, na.rm = T)
  , max(fecha_de_firma, na.rm = T)
  , paste0(sum(round(valor_del_contrato/1000000, 0), na.rm = T), " M")
  ), departamento][order(N, decreasing = T)]

saveRDS(object = d, file = sprintf("6. Viz/shiny/data/secop.RDS"))
write.table(x = d, file = sprintf("6. Viz/shiny/data/secop.csv"), sep = ",", na = "", row.names = F, fileEncoding = "latin1")
