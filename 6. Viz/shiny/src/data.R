require(data.table)

d <- readRDS(parameters$data_filename)
nums_ <- parameters$nums_
cats_ <- parameters$cats_
date_ <- parameters$date_

print(colnames(d))

d$dias_adicionados <- NULL
d$tipodocproveedor <- NULL
d$codigo_de_categoria_principal <- NULL
d$estado_contrato <- NULL
d$orden <- NULL

setnames(x = d, old = "nombre_entidad", new = "Entity name")
setnames(x = d, old = "nit_entidad", new = "NIT")
setnames(x = d, old = "departamento", new = "Department")
setnames(x = d, old = "ciudad", new = "City")
setnames(x = d, old = "orden", new = "Order")
setnames(x = d, old = "id_contrato", new = "Contract ID")
setnames(x = d, old = "estado_contrato", new = "Contract state")
setnames(x = d, old = "codigo_de_categoria_principal", new = "Main Category ID")
setnames(x = d, old = "descripcion_del_proceso", new = "Contractual Object")
setnames(x = d, old = "tipo_de_contrato", new = "Contract Type")
setnames(x = d, old = "modalidad_de_contratacion", new = "Contract Modality")
setnames(x = d, old = "fecha_de_firma", new = "Sign date")
setnames(x = d, old = "fecha_de_inicio_de_ejecucion", new = "Start execution date")
setnames(x = d, old = "fecha_de_fin_de_ejecucion", new = "End execution date")
setnames(x = d, old = "tipodocproveedor", new = "Provider Doc Type")
setnames(x = d, old = "documento_proveedor", new = "Provider ID")
setnames(x = d, old = "proveedor_adjudicado", new = "Provider")
setnames(x = d, old = "valor_del_contrato", new = "Contract Value")
setnames(x = d, old = "origen_de_los_recursos", new = "Budget origin")

print(nums_)
print(cats_)
print(date_)

# Categories
for (i in 1:length(parameters$cats_)) { # i = 2
  setnames(x = d, old = parameters$cats_[i], new = paste0("cat", i, "_"))
}

# Numeric values
for (i in 1:length(parameters$nums_)) { # i = 2
  setnames(x = d, old = parameters$nums_[i], new = paste0("num", i, "_"))
}

# Date
setnames(x = d, old = parameters$date_, new = "date_")

# Grouping of date to use in the filter
d[!is.na(date_), Weekly := paste0(year(date_), "-", ifelse(isoweek(date_) < 10, "0", ""), isoweek(date_))]
d[!is.na(date_), Monthly := paste0(year(date_), "-", ifelse(month(date_) < 10, "0", ""), month(date_))]
d[!is.na(date_), Quarterly := paste0(year(date_), "-", quarter(date_))]
d[!is.na(date_), Yearly := year(date_)]
