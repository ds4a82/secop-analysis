library(rstudioapi)
library(tidyverse)

#Read Inputs

current_path <- dirname(getActiveDocumentContext()$path)
coltypes_secop_I <- list("Nombre de la Entidad" = "c", "NIT de la Entidad" = "c", "Departamento Entidad" = "c", "Municipio Entidad" = "c", "Nivel Entidad" = "c", "Numero del Contrato" = "c", "Estado del Proceso" = "c", "ID Objeto a Contratar" = "c", "Detalle del Objeto a Contratar" = "c", "Tipo de Contrato" = "c", "Regimen de Contratacion" = "c", "Fecha de Firma del Contrato" = "c", "Fecha Ini Ejec Contrato" = "c", "Fecha Fin Ejec Contrato" = "c", "Tipo Identifi del Contratista" = "c", "Identificacion del Contratista" = "c", "Nom Raz Social Contratista" = "c", "Valor Contrato con Adiciones" = "d", "Origen de los Recursos" = "c", "Tiempo Adiciones en Dias" = "i")
coltypes_secop_II <- list("Nombre Entidad" = "c", "Nit Entidad" = "c", "Departamento" = "c", "Ciudad" = "c", "Orden" = "c", "ID Contrato" = "c", "Estado Contrato" = "c", "Codigo de Categoria Principal" = "c", "Descripcion del Proceso" = "c", "Tipo de Contrato" = "c", "Modalidad de Contratacion" = "c", "Fecha de Firma" = "c", "Fecha de Inicio de Ejecucion" = "c", "Fecha de Fin de Ejecucion" = "c", "TipoDocProveedor" = "c", "Documento Proveedor" = "c", "Proveedor Adjudicado" = "c", "Valor del Contrato" = "d", "Origen de los Recursos" = "c", "Dias Adicionados" = "i")
input_secop_I <- read_delim(paste(current_path,"/SECOP_I.csv", sep=""), delim = ",", col_types = do.call(cols_only, coltypes_secop_I))
input_secop_II <- read_delim(paste(current_path,"/SECOP_II.csv", sep=""), delim = ",", col_types = do.call(cols_only, coltypes_secop_II))
secop_I <- input_secop_I[c("Nombre de la Entidad", "NIT de la Entidad", "Departamento Entidad", "Municipio Entidad", "Nivel Entidad", "Numero del Contrato", "Estado del Proceso", "ID Objeto a Contratar", "Detalle del Objeto a Contratar", "Tipo de Contrato", "Regimen de Contratacion", "Fecha de Firma del Contrato", "Fecha Ini Ejec Contrato", "Fecha Fin Ejec Contrato", "Tipo Identifi del Contratista", "Identificacion del Contratista", "Nom Raz Social Contratista", "Valor Contrato con Adiciones", "Origen de los Recursos", "Tiempo Adiciones en Dias")]
secop_II <- input_secop_II[c("Nombre Entidad", "Nit Entidad", "Departamento", "Ciudad", "Orden", "ID Contrato", "Estado Contrato", "Codigo de Categoria Principal", "Descripcion del Proceso", "Tipo de Contrato", "Modalidad de Contratacion", "Fecha de Firma", "Fecha de Inicio de Ejecucion", "Fecha de Fin de Ejecucion", "TipoDocProveedor", "Documento Proveedor", "Proveedor Adjudicado", "Valor del Contrato", "Origen de los Recursos", "Dias Adicionados")]
names(secop_I) <- c("NOMBRE_ENTIDAD", "NIT_ENTIDAD", "DEPARTAMENTO", "CIUDAD", "ORDEN", "ID_CONTRATO", "ESTADO_CONTRATO", "CODIGO_DE_CATEGORIA_PRINCIPAL", "DESCRIPCION_DEL_PROCESO", "TIPO_DE_CONTRATO", "MODALIDAD_DE_CONTRATACION", "FECHA_DE_FIRMA", "FECHA_DE_INICIO_DE_EJECUCION", "FECHA_DE_FIN_DE_EJECUCION", "TIPODOCPROVEEDOR", "DOCUMENTO_PROVEEDOR", "PROVEEDOR_ADJUDICADO", "VALOR_DEL_CONTRATO", "ORIGEN_DE_LOS_RECURSOS", "DIAS_ADICIONADOS")
names(secop_II) <- c("NOMBRE_ENTIDAD", "NIT_ENTIDAD", "DEPARTAMENTO", "CIUDAD", "ORDEN", "ID_CONTRATO", "ESTADO_CONTRATO", "CODIGO_DE_CATEGORIA_PRINCIPAL", "DESCRIPCION_DEL_PROCESO", "TIPO_DE_CONTRATO", "MODALIDAD_DE_CONTRATACION", "FECHA_DE_FIRMA", "FECHA_DE_INICIO_DE_EJECUCION", "FECHA_DE_FIN_DE_EJECUCION", "TIPODOCPROVEEDOR", "DOCUMENTO_PROVEEDOR", "PROVEEDOR_ADJUDICADO", "VALOR_DEL_CONTRATO", "ORIGEN_DE_LOS_RECURSOS", "DIAS_ADICIONADOS")

#Merge secop_I and secop_II

secop_I$FUENTE <- "SECOP_I"
secop_II$FUENTE <- "SECOP_II"
data_secop <- rbind(secop_I, secop_II)

#Outputs

write.table(data_secop, paste(current_path, "/data_secop.csv", sep = ""), sep = ";", row.names = F, fileEncoding ="latin1")

