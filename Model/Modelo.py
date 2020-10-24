#!/usr/bin/env python
# coding: utf-8

# In[1]:


# get_ipython().run_line_magic('pip', 'uninstall pandas')
# get_ipython().run_line_magic('pip', 'install pandas==1.1.1')
# get_ipython().run_line_magic('pip', 'install Contexto')
import pandas as pd
import numpy as np
from sqlalchemy import create_engine
import warnings
warnings.filterwarnings("ignore")
from contexto.limpieza import *
from contexto.exploracion import *
import plotly.express as px
import plotly.offline as py #visualization
import plotly.graph_objs as go
from plotly.offline import *


# In[2]:


db_string= 'postgresql://postgres:ds4a#202082@ds4a-instance.c0wb6thhjklc.us-east-1.rds.amazonaws.com/db_secop'
connection_info = create_engine(db_string).connect()


# In[3]:


query_SECOPI='''SELECT * FROM secop WHERE fuente LIKE '%SECOP_I%' AND fecha_de_firma LIKE '%20%' ORDER BY fecha_de_firma DESC LIMIT 1000000 '''


# In[4]:


df_raw_secopi=pd.read_sql(query_SECOPI,con=connection_info)
get_ipython().run_line_magic('time', '')


# In[5]:


df_raw_secopi.head()


# In[6]:


df_raw_secopi.columns.to_list()


# In[88]:


df_secopi=df_raw_secopi.sample(frac=0.6,random_state=82)


# 

# In[89]:


df_secopi[ 'descripcion_del_proceso']=df_secopi[ 'descripcion_del_proceso'].apply(lambda x: limpieza_texto(x, n_min=4, quitar_acentos=True,quitar_numeros=False,lista_palabras=['para','los','las','del','con','.']))


# In[90]:


df_secopi


# In[91]:


Descripciones_secopi=re.sub("[^a-zA-Z]", " ", df_secopi['descripcion_del_proceso'].to_string())


# In[93]:


df_dist = pd.DataFrame.from_dict(frecuencia_ngramas(Descripciones_secopi,1), orient='index')
df_dist=df_dist.reset_index()
df_dist.columns=["Palabra","Frecuencia"]
df_dist=df_dist.sort_values(by="Frecuencia",ascending=False).reset_index(drop= True)
fig=px.bar(df_dist[:25],x="Palabra",y="Frecuencia",text="Frecuencia", title="Gráfico de Frecuencia de palabras frecuentes")
fig.show()
df_dist


# In[94]:


Lista_Descripciones= df_secopi['descripcion_del_proceso'].to_list()


# In[95]:



from gensim.models import Word2Vec
from nltk.cluster import KMeansClusterer

def word_sentinizer(txt, model):
    text_vect = []
    no_words = 0
    for word in txt:
        if no_words ==  0:
            text_vect = model[word]
        else:
            text_vect = np.add(text_vect, model[word])
        no_words += 1
    return np.asarray(text_vect) / no_words

# Vectorizing withot cleaning
X = []
model = Word2Vec(Lista_Descripciones, min_count = 1)
for text in Lista_Descripciones:
    X.append(word_sentinizer(text, model))


# In[99]:


X[0]


# In[13]:


#from contexto.vectorizacion import *


# In[16]:


#v_doc2vec = VectorizadorDoc2Vec(n_elementos=1000, epocas=50, minima_cuenta=5)


# In[17]:


#v_doc2vec.entrenar_modelo(Lista_Descripciones[:10000], archivo_salida='v_doc2vec.pk')


# In[30]:


#v_bow = VectorizadorFrecuencias()
#v_bow.ajustar(Lista_Descripciones, archivo_salida='v_bow.pk')


# In[100]:


import nltk
import time 
for cluster_size in [1, 2, 3, 5, 10, 20]:
    for data_size in [10, 100, 300, 500, 1000, 2000, 3000, 5000]:
        x = np.random.rand(data_size,20)
        start = time.time()
        kclusterer = KMeansClusterer(cluster_size, distance=nltk.cluster.util.cosine_distance)
        assigned_clusters = kclusterer.cluster(X, assign_clusters=False)
        time_taken = time.time() - start
        print(cluster_size, data_size, time_taken)


# In[102]:


NUM_CLUSTERS=2
kclusterer = KMeansClusterer(NUM_CLUSTERS, distance=nltk.cluster.util.cosine_distance, repeats=25)
assigned_clusters = kclusterer.cluster(X, assign_clusters=False)

