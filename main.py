# !pip install pandas
# !pip install sodapy
# pip install https://github.com/pandas-profiling/pandas-profiling/archive/master.zip

import sys
!jupyter nbextension enable --py widgetsnbextension
!pip uninstall pandas_profiling
!pip install https://github.com/pandas-profiling/pandas-profiling/archive/master.zip

import pandas as pd
import numpy as np
from sodapy import Socrata


client = Socrata("www.datos.gov.co", None)

secop1 = pd.DataFrame.from_records(client.get("xvdy-vvsk", limit=5000))
secop2 = pd.DataFrame.from_records(client.get("p6dx-8zbt", limit=5000))
secop2_1 = pd.DataFrame.from_records(client.get("jbjy-vk9h", limit=5000))
tienda = pd.DataFrame.from_records(client.get("rgxm-mmea", limit=5000))
secop_integrado = pd.DataFrame.from_records(client.get("rpmr-utcd", limit=5000)) # SECOP Integrado

tienda.groupby(by = 'sector_de_la_entidad').agg(['count'])
tienda.groupby(by = 'estado').agg(['count'])
tienda.groupby(by = 'solicitud').agg(['count'])


secop1.columns
for col in secop1.columns:
  print("%s:" %col)
  print(secop1[col])

secop1['ruta_proceso_en_secop_i'].apply(lambda x: len(x)).unique()


secop1.describe()
secop2.info()

secop2['urlproceso']

secop1.columns in secop2.columns



def summary_table(df, cat_, cats_, num_, order_by_ = "N", top = 3):
  df['cat_'] = df[cat_]
  t1 = 


# R
summary_table <- function(d, category_, categoricals, numerical, order_by_ = "N", top = 3){ # variable ="payment_method"
  # No hay manera que numerical sera nulo porque se usa para agrupar el categoricals
  d$category_ <- d[[category_]]
  
  # Top Categorical Variablse
  t1 <- d[!is.na(category_), .N, keyby = category_]
  
  for(category in categoricals){ # category = "Departamento"
    t2 <- top_categories(d, cat1 = category_, cat2 = category, var = numerical, top = top)
    t1 <- t1[t2]
  }
  # Numerical variable
  t2 <- summary_numerical(d = d, cat1 = category_, var1 = numerical)
  t1 <- t1[t2]

  t1$order_by_ <- t1[[order_by_]]
  t1 <- t1[order(order_by_, decreasing = T)]
  t1$order_by_ <- NULL
  
  setnames(t1, old = "category_", new = category_)
  setkeyv(x = t1, cols = category_)
  t1
}


# Hice esta modicicacón
