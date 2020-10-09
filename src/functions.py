def Nombre_Limpio(text):
  words=text.split("_")
  s= " ".join(words)
  return s
  
def Outliers(df,cols):
  df_copy=df.copy()
  for col in cols:
    ValMax=df_copy[col].quantile(0.75)+1.5*(df_copy[col].quantile(0.75)-df_copy[col].quantile(0.25))
    df_copy=df_copy[df_copy[col]<ValMax].reset_index(drop=True)
  return df_copy

def GraficosConteos(df,w):
  Prueba=df[w].value_counts().reset_index()
  Prueba.columns=[w,"Cantidad de registros"]
  Prueba=Prueba.sort_values(by="Cantidad de registros",ascending=False)
  fig=px.bar(Prueba[:20],x=w,y="Cantidad de registros",text="Cantidad de registros", title=f"Gráfico de conteo {w}")
  fig.show()
def GraficosBoxplot(df,w):
  fig=px.box(df,y=w, title=f"Gráfico de boxplot {w}")
  fig.show()

