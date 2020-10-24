# -*- coding: utf-8 -*-
# RUNS ON PYTHON 2!
# Referencia: https://www.machinelearningplus.com/nlp/topic-modeling-gensim-python/
# Reference: https://ahmedbesbes.com/how-to-mine-newsfeed-data-and-extract-interactive-insights-in-python.html
import os
os.chdir("/home/camilo/CRISP-DM/Python/Topic Modelling/")

import re
import datetime
import pandas as pd
pd.options.display.max_columns = 200
pd.options.mode.chained_assignment = None

import numpy as np

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

from nltk.tokenize import word_tokenize, sent_tokenize
from string import punctuation

from sklearn.manifold import TSNE
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.decomposition import TruncatedSVD
from sklearn.cluster import MiniBatchKMeans, KMeans

import warnings
warnings.filterwarnings("ignore", category=DeprecationWarning)
from sklearn.cluster import MiniBatchKMeans, KMeans
from sklearn.metrics import silhouette_score
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import Normalizer
from sklearn.decomposition import NMF

from collections import Counter

import warnings
warnings.filterwarnings(action='ignore', category=UserWarning, module='gensim')
import gensim
import gensim.corpora as corpora
from gensim import matutils
from gensim.models import CoherenceModel
from gensim.models import wrappers

# ---- Visualize INTERACTIVE 2-D graph using bokeh ----
from bokeh.resources import CDN
from bokeh.embed import file_html
import bokeh.plotting as bp
from bokeh.palettes import d3
import bokeh.models as bmo
from bokeh.models import HoverTool, BoxSelectTool


# ---- Get Graph of Categories ----
def plotCategories(data, column, filename = "images/categories.png"):
  image = data[column].value_counts(normalize=True).plot(kind='pie', grid=True, figsize=(9, 9))
  plt.savefig(filename)
  plt.close()

def exportWordHistogram(data, colname, filename = "images/histogram.png"):
  fig = data[colname].map(len)
  fig.hist(figsize=(15, 5), bins=100)
  plt.savefig(filename)
  plt.close()

def tokenize(data, column = "description", stop_word_path = '/home/camilo/CRISP-DM/Python/Topic Modelling/data/stopwords.txt'):
  def _removeNonAscii(s): 
    return "".join(i for i in s if ord(i)<128)
  
  def clean_text(text):
    text = text.lower()
    text = re.sub(r"what's", "what is ", text)
    text = text.replace('(ap)', '')
    text = re.sub(r"\'s", " is ", text)
    text = re.sub(r"\'ve", " have ", text)
    text = re.sub(r"can't", "cannot ", text)
    text = re.sub(r"n't", " not ", text)
    text = re.sub(r"i'm", "i am ", text)
    text = re.sub(r"\'re", " are ", text)
    text = re.sub(r"\'d", " would ", text)
    text = re.sub(r"\'ll", " will ", text)
    text = re.sub(r'\W+', ' ', text)
    text = re.sub(r'\s+', ' ', text)
    text = re.sub(r"\\", "", text)
    text = re.sub(r"\'", "", text)    
    text = re.sub(r"\"", "", text)
    text = re.sub('[^a-zA-Z ?!]+', '', text)
    text = _removeNonAscii(text)
    text = text.strip()
    return text
  
  # ---- Tokenize text content ----
  def tokenizer(text):
    import functools
    text = clean_text(text)
    print(text)
    tokens = [word_tokenize(sent) for sent in sent_tokenize(text)]
    tokens = list(functools.reduce(lambda x,y: x+y, tokens))
    tokens = list(filter(lambda token: token not in (stop_words + list(punctuation)) , tokens))
    return tokens
  
  # ---- Prepare Stop Words ---- 
  stop_words = []
  f = open(stop_word_path, 'r')
  for l in f.readlines():
    stop_words.append(l.replace('\n', ''))
  f.close()
  
  # print(len(stop_words))
  
  # ---- Clean Text ----
  # data['description'] = data['description'].map(lambda d: str(d, 'utf-8')) # python3
  def enc(text):
    return unicode(text.decode("utf-8"))
    # print(text)
    # return text.encode('utf-8', "ignore").decode('utf-8').encode(errors = 'ignore')
  
  data[column] = data[column].apply(lambda text: enc(text)) # Python2 # text = data[column].values[10]
  data['tokens'] = data[column].apply(lambda d: tokenizer(d))
  
  for descripition, tokens in zip(data[column].head(5), data['tokens'].head(5)):
    print('%s:' %(column), descripition)
    print('tokens:', tokens)
    print() 
  
  return data 

def prepareData(data, column, stop_word_path = '/home/camilo/CRISP-DM/Python/Topic Modelling/data/stopwords.txt'):
  # ---- Drop null values in description ----
  data = data.drop_duplicates(column)
  data = data[~data[column].isnull()]
  print(data.shape)
  
  # ---- Get Length of Description columns ----
  # data = data[(data[column].map(len) > 140) & (data[column].map(len) <= 300)]
  data.reset_index(inplace=True, drop=True)
  data = tokenize(data, column, stop_word_path)
  print(data.shape)
  
  # Columns: category and description
  return data

# ---- Top Key Words per Category ----
def get_top_keywords_per_category(data, top = 10):
  from collections import Counter
  def keywords(category):
      tokens = data[data['category'] == category]['tokens']
      alltokens = []
      for token_list in tokens:
          alltokens += token_list
      counter = Counter(alltokens)
      return counter.most_common(top)
  r = {}
  for category in set(data['category']):
    r[category] = keywords(category)
    # print('category :', category)
    # print('top 10 keywords:', keywords(category))
    # print('---')
  
  return r

# ---- Term Inversed Frequency ----
def GetVZandTFIDF(data):
  vectorizer = TfidfVectorizer(
    min_df=5
    , analyzer='word'
    , ngram_range=(1, 2)
    , stop_words='english')
  vz = vectorizer.fit_transform(list(data['tokens'].map(lambda tokens: ' '.join(tokens))))
  vz.shape
  
  tfidf = dict(zip(vectorizer.get_feature_names(), vectorizer.idf_))
  tfidf = pd.DataFrame(columns=['tfidf']).from_dict(dict(tfidf), orient='index')
  tfidf.columns = ['tfidf']
  return vz, tfidf, vectorizer

def exportHistogramLTIDF(tfidf, filename = "images/histogram_tfidf.png"):
  fig = tfidf.tfidf
  fig.hist(figsize=(15, 5))
  plt.savefig(filename)
  plt.close()

# ---- Word Cloud of TFIDF ----
def plot_word_cloud(terms, filename = "wordcloud.png", width = 890, height = 501):
  from wordcloud import WordCloud
  text = terms.index
  text = ' '.join(list(text))
  # lower max_font_size
  wordcloud = WordCloud(
    width = width
    , height = height
    , background_color ='white'
    # , stopwords = stopwords
    , min_font_size = 10
    )
  wordcloud.generate(text)
  wordcloud.to_file(filename)


# ---- Get 2-dimension coodinates and plot them with its categories ----
def GetTSNE_TFIDF(data, vz, model_location = 'data/tsne_tfidf.csv', n_components = 50, n_iter = 500):
  svd = TruncatedSVD(n_components=n_components, random_state=0)
  svd_tfidf = svd.fit_transform(vz)
  print(svd_tfidf.shape)
  if not os.path.exists(model_location):
    # run this (takes time)
    tsne_model = TSNE(n_components=2, verbose=1, random_state=0, n_iter=n_iter)
    tsne_tfidf = tsne_model.fit_transform(svd_tfidf)
    print(tsne_tfidf.shape)
    tsne_tfidf_df = pd.DataFrame(tsne_tfidf)
    tsne_tfidf_df.columns = ['x', 'y']
    tsne_tfidf_df['category'] = data['category']
    tsne_tfidf_df['description'] = data['description']
    tsne_tfidf_df.to_csv(model_location, encoding='utf-8', index=False)
  else:
  # or import the dataset directly
    tsne_tfidf_df = pd.read_csv(model_location)
  return tsne_tfidf_df

def plotTFIDF(tsne_tfidf_df, filename = "images/2d_plane.png"):
  groups = tsne_tfidf_df.groupby('category')
  fig, ax = plt.subplots(figsize=(15, 10))
  ax.margins(0.05) # Optional, just adds 5% padding to the autoscaling
  for name, group in groups:
      ax.plot(group.x, group.y, marker='o', linestyle='', label=name)
  
  ax.legend()
  plt.savefig(filename)
  plt.close()

# ---- Visualize INTERACTIVE 2-D graph using bokeh ----
def plotTSNE_DF(tsne_df, filename = 'tSNE_Graph.html', char_lenght = 50, title="tSNE Clustering", plot_width=890, plot_height=501):
  def _printtext(x, char_lenght):
    return " ".join(x.split()[0:char_lenght])
  
  tsne_df['description'] = tsne_df['description'].apply(lambda x: _printtext(x, char_lenght))
  
  plot_tsne = bp.figure(plot_width=plot_width, plot_height=plot_height, title=title,
      tools="pan,wheel_zoom,box_zoom,reset,hover,previewsave",
      x_axis_type=None, y_axis_type=None, min_border=1)
  
  palette = d3['Category20'][20] + d3['Category20b'][20]
  color_map = bmo.CategoricalColorMapper(factors=tsne_df['topic'].unique(), palette=palette)
  
  plot_tsne.scatter('x', 'y'
    , source = tsne_df
    , color={'field': 'topic', 'transform': color_map}
    , legend='topic')
  hover = plot_tsne.select(dict(type=HoverTool))
  hover.tooltips={"description": "@description", "topic": "@topic", "category": "@category", "username": "@id"}
  
  html = file_html(plot_tsne, CDN, "Plot")
  f = open(filename, 'w')
  f.write(html)
  f.close()
  # show(plot_lda)

def exportTFIDF_HTML(tsne_tfidf_df, filename = 'images/tfidf.html', char_lenght = 200, title = "TF-IDF Clustering", plot_width=890, plot_height=600):
  # ---- Visualize INTERACTIVE 2-D graph using bokeh ----
  from bokeh.resources import CDN
  from bokeh.embed import file_html
  import bokeh.plotting as bp
  from bokeh.palettes import d3
  import bokeh.models as bmo
  from bokeh.models import HoverTool, BoxSelectTool
  
  tsne_tfidf_df['description'] = tsne_tfidf_df['description'].apply(lambda x: x[1:char_lenght])
  
  plot_tfidf = bp.figure(plot_width=plot_width, plot_height=plot_height, title=title,
      tools="pan,wheel_zoom,box_zoom,reset,hover,previewsave",
      x_axis_type=None, y_axis_type=None, min_border=1)
  
  # string = "Category%s" %(len(tsne_tfidf_df['category'].unique()))
  palette = d3["Category20"][len(tsne_tfidf_df['category'].unique())]
  color_map = bmo.CategoricalColorMapper(factors=tsne_tfidf_df['category'].map(str).unique(), palette=palette)
  
  
  plot_tfidf.scatter(x='x', y='y', color={'field': 'category', 'transform': color_map}, 
                     legend='category', source=tsne_tfidf_df)
  hover = plot_tfidf.select(dict(type=HoverTool))
  hover.tooltips={"description": "@description", "category":"@category"}
  
  html = file_html(plot_tfidf, CDN, "Plot")
  f = open(filename, 'w')
  f.write(html)
  f.close()

def exportKmeansDF(kmeans_df, filename = 'KMeansGraph.html', char_lenght = 200, title="KMeans clustering", plot_width=890, plot_height=600):
  import bokeh.plotting as bp
  from bokeh.palettes import d3
  import bokeh.models as bmo
  from bokeh.models import HoverTool, BoxSelectTool
  from bokeh.embed import file_html
  from bokeh.resources import CDN
  plot_kmeans = bp.figure(plot_width=plot_width, plot_height=plot_height, title=title,
      tools="pan,wheel_zoom,box_zoom,reset,hover,previewsave",
      x_axis_type=None, y_axis_type=None, min_border=1)
  
  palette = d3['Category20'][20] + d3['Category20b'][20] 
  color_map = bmo.CategoricalColorMapper(factors=kmeans_df['cluster'].unique(), palette=palette)
  
  plot_kmeans.scatter('x', 'y', source=kmeans_df, 
                      color={'field': 'cluster', 'transform': color_map}, 
                      legend='cluster')
  hover = plot_kmeans.select(dict(type=HoverTool))
  hover.tooltips={"description": "@description", "cluster": "@cluster", "category": "@category"}
  
  html = file_html(plot_kmeans, CDN, "Plot")
  f = open(filename, 'w')
  f.write(html)
  f.close()
  # show(plot_kmeans)

def GetClustersPerformance(vz, filename = "KMeansGroupTest.png", k_max = 80):
  vz.shape
  distorsions = []
  sil_scores = []
  for k in range(2, k_max): # k = 3
    print("Cluster : %s" %(k))
    kmeans_model = MiniBatchKMeans(n_clusters=k, init='k-means++', n_init=1, random_state=42,  
                         init_size=1000, verbose=False, max_iter=1000)
    kmeans_model.fit(vz)
    sil_score = silhouette_score(vz, kmeans_model.labels_)
    sil_scores.append(sil_score)
    distorsions.append(kmeans_model.inertia_)
    del(kmeans_model)
  
  f, (ax1, ax2) = plt.subplots(2, 1, sharex=True, figsize=(15, 10))
  
  ax1.plot(range(2, k_max), distorsions)
  ax1.set_title('Distorsion vs num of clusters')
  ax1.grid(True)
  
  ax2.plot(range(2, k_max), sil_scores)
  ax2.set_title('Silhouette score vs num of clusters')
  ax2.grid(True)
  
  plt.savefig(filename)
  plt.close()

def GetKmeans(vz, num_clusters):
  kmeans_model = MiniBatchKMeans(n_clusters=num_clusters, init='k-means++', n_init=1, random_state=42,
                           init_size=1000, batch_size=1000, verbose=False, max_iter=1000, )
  kmeans = kmeans_model.fit(vz)
  
  kmeans_clusters = kmeans.predict(vz)
  kmeans_distances = kmeans.transform(vz)
  for (i, desc),category in zip(enumerate(data.description),data['category']):
    if(i < 5):
      print("Cluster " + str(kmeans_clusters[i]) + ": " + desc + 
            "(distance: " + str(kmeans_distances[i][kmeans_clusters[i]]) + ")")
      print('category: ',category)
      print('---')
  return kmeans

# Hot keywords that describe each cluster
def GetKeywordsKmeans(kmeans, vectorizer):
  sorted_centroids = kmeans.cluster_centers_.argsort()[:, ::-1]
  terms = vectorizer.get_feature_names()
  all_keywords = []
  for i in range(kmeans.n_clusters):
      topic_keywords = []
      for j in sorted_centroids[i, :10]:
          topic_keywords.append(terms[j])
      all_keywords.append(topic_keywords)
  
  keywords_df = pd.DataFrame(index=['topic_{0}'.format(i) for i in range(num_clusters)], 
                             columns=['keyword_{0}'.format(i) for i in range(10)],
                             data=all_keywords)
  return keywords_df

def GetKmeansDF(kmeans, data, vz, model_location = 'tsne_kmeans.csv', n_components = 2, n_iter = 500):
  if not os.path.exists(model_location):
    kmeans_clusters = kmeans.predict(vz)
    kmeans_distances = kmeans.transform(vz)
    tsne_model = TSNE(n_components=n_components, verbose=1, random_state=0, n_iter=n_iter)
    tsne_kmeans = tsne_model.fit_transform(kmeans_distances)
    kmeans_df = pd.DataFrame(tsne_kmeans, columns=['x', 'y'])
    kmeans_df['cluster'] = kmeans_clusters
    kmeans_df['cluster'] = kmeans_df['cluster'].map(str)
    kmeans_df['description'] = data['description']
    kmeans_df['category'] = data['category']
    kmeans_df.to_csv(model_location, index=False, encoding='utf-8')
  else:
    kmeans_df = pd.read_csv(model_location)
    kmeans_df['cluster'] = kmeans_df['cluster'].map(str)
  return kmeans_df


# ---- LDA modeling to get topics ----

def setCorpusAux(data):
  # aux = data.copy()
  # bigram = gensim.models.Phrases(aux['tokens'], min_count=5, threshold=100)
  # bigram_mod = gensim.models.phrases.Phraser(bigram)
  # aux['tokens_bigram'] = aux['tokens'].map(lambda tokens: bigram_mod[tokens])
  # id2word = corpora.Dictionary(aux['tokens_bigram'])
  # texts = aux['tokens_bigram'].values
  # corpus = [id2word.doc2bow(text) for text in texts]
  
  bigram = gensim.models.Phrases(data['tokens'], min_count=5, threshold=100)
  bigram_mod = gensim.models.phrases.Phraser(bigram)
  data['tokens_bigram'] = data['tokens'].map(lambda tokens: bigram_mod[tokens])
  id2word = corpora.Dictionary(data['tokens_bigram'])
  texts = data['tokens_bigram'].values
  corpus = [id2word.doc2bow(text) for text in texts]
  return corpus, id2word

def plot_coherences(x, y, filename):
  fig = plt.figure(figsize=(15, 5))
  plt.title('Choosing the optimal number of topics')
  plt.xlabel('Number of topics')
  plt.ylabel('Coherence')
  plt.grid(True)
  plt.plot(x, y)
  plt.savefig(filename)
  plt.close()

def exploreLDAmodels(data, corpus, id2word, topic_range=range(5, 40, 5), filename = "LDA_Topics.png"):
  coherences = []
  for num_topics in topic_range: # num_topics = 5
    # lda_model = Mallet_model(corpus, id2word, num_topics)
    lda_model = LDA_model(corpus, id2word, num_topics, passes=5)
    perplexity = lda_model.log_perplexity(corpus) # The lower the better
    coherence_model = CoherenceModel(model=lda_model, texts=data['tokens_bigram'].values, dictionary=id2word, coherence='c_v') # The higher the better
    coherence = coherence_model.get_coherence() # The higher the better
    coherences.append(coherence)
    print("LDA Model %s. Number of topics: %s. Coherence: %s. Perplexity: %s" %(datetime.datetime.now().strftime("%d/%m/%Y %H:%M:%S"), num_topics, round(coherence, 3), round(perplexity, 2)))
    plot_coherences(x = topic_range[0:len(coherences)], y = coherences, filename = filename)

def Mallet_model(corpus, id2word, num_topics, mallet_path = '/home/camilo/CRISP-DM/Python/Topic Modelling/mallet-2.0.8/bin/mallet'):
  # wget http://mallet.cs.umass.edu/dist/mallet-2.0.8.zip
  # unzip mallet-2.0.8.zip
  # os.environ.update({'MALLET_HOME': r'/home/camilo/CRISP-DM/Python/Topic Modelling/mallet-2.0.8/'})
  return gensim.models.wrappers.LdaMallet(
    mallet_path
    , corpus=corpus
    , num_topics=num_topics
    , id2word=id2word
    )

def LDA_model(corpus, id2word, num_topics, passes=1, chunksize = 100):
  # print("LDA Model. Number of topics: %s. Passes: %s" %(num_topics, passes))
  # Referencia: https://www.machinelearningplus.com/nlp/topic-modeling-gensim-python/
  return gensim.models.ldamodel.LdaModel(corpus=corpus
    , id2word=id2word
    , num_topics=num_topics
    , random_state=100
    , eval_every=10 # eval_every determines how often the model parameters should be updated
    , chunksize=chunksize # chunksize is the number of documents to be used in each training chunk
    , passes=passes # passes is the total number of training passes
    , per_word_topics=True
    , alpha='auto'
    )

def display_topics(model):
    topics = model.show_topics(num_topics=model.num_topics, formatted=False, num_words=10)
    topics = map(lambda c: map(lambda cc: cc[0], c[1]), topics)
    df = pd.DataFrame(topics)
    df.index = ['topic_{0}'.format(i) for i in range(model.num_topics)]
    df.columns = ['keyword_{0}'.format(i) for i in range(1, 10+1)]
    return df


# A cell i,j is the probabily of topic j in the document i.
def get_document_topic_matrix(corpus, model):
  num_topics = model.num_topics
  matrix = []
  for row in corpus:
    output = np.zeros(num_topics)
    doc_proba = model[row][0]
    for doc, proba in doc_proba:
      output[doc] = proba
    matrix.append(output)
  matrix = np.array(matrix)
  return matrix

# tSNE outputs a distribution of topic for each document. We'll assume that a document's topic is the one with the highest probability. 
def getTSNE_DF(data, corpus, best_model, n_components=2, n_iter=500):
  matrix = get_document_topic_matrix(corpus, best_model)
  # doc_topic = best_model.get_document_topics(corpus)
  tsne_keys = []
  for i, desc in enumerate(data[column]):
    tsne_keys.append(np.argmax(matrix[i, :]) + 1) # Se suma 1 para que los tópicos comiencen desde 1 y no desde 0. 
  tsne_model = TSNE(n_components=n_components, verbose=1, random_state=0, n_iter=n_iter)
  tsne = tsne_model.fit_transform(matrix)
  tsne_df = pd.DataFrame(tsne, columns=['x', 'y'])
  tsne_df['topic'] = tsne_keys
  tsne_df['topic'] = tsne_df['topic'].map(str)
  tsne_df[column] = data[column]
  tsne_df['id'] = data['id']
  tsne_df['category'] = data['category']
  return tsne_df

def exportLDA_vis(best_model, corpus, id2word, filename = 'pyLDAvis.html'):
  import pyLDAvis
  import pyLDAvis.gensim
  panel = pyLDAvis.gensim.prepare(best_model, corpus, id2word)
  pyLDAvis.save_html(panel, filename)

# ---- Linear Algebra for Topic Modelling: NMF: Non-negative Matrix Factorization ----
def getNMF(data, vz, num_topics, top_words = 10, max_topics = 10):
  vectorizer = TfidfVectorizer(min_df=5, analyzer='word', ngram_range=(1, 2), stop_words='english')
  vz = vectorizer.fit_transform(list(data['tokens'].map(lambda tokens: ' '.join(tokens))))
  
  nmf = NMF(n_components=num_topics, random_state=1, alpha=.1, l1_ratio=.5, init='nndsvd').fit(vz)
  feature_names = vectorizer.get_feature_names()
  no_top_words = top_words
  
  for topic_idx, topic in enumerate(nmf.components_[:max_topics]):
    print("Topic %d:"% (topic_idx))
    print(" | ".join([feature_names[i]
    for i in topic.argsort()[:-no_top_words - 1:-1]]))


# # Data Reading. Most important columns: category and description
# # data = pd.read_csv('./data/news.csv')
# data = pd.read_excel('payu/tables.xlsx', sheet_name=1, encoding= "utf-8")
# data = data[['id', 'Description', 'Stage', 'Detailed_Description']]
# 
# data = data[~pd.isnull(data['Description'])]
# data.loc[pd.isnull(data['Stage']), 'Stage'] = "Unassigned"
# 
# data.columns = ['id', 'description', 'category', 'description1']
# 
# data = prepareData(data, column = "description")
# data = tokenize(data, column = "description")
# 
# # plotCategories(data, column = "category", filename = "payu/categories.png")
# 
# exportWordHistogram(data, 'description', filename = "payu/histogram.png")
# 
# top = get_top_keywords_per_category(data)
# 
# vz, tfidf, vectorizer = GetVZandTFIDF(data)
# 
# exportHistogramLTIDF(tfidf, filename = "payu/histogram_tfidf.png")
# 
# plot_word_cloud(tfidf.sort_values(by=['tfidf'], ascending=True).head(40), file = "payu/wordcloud_least")
# plot_word_cloud(tfidf.sort_values(by=['tfidf'], ascending=False).head(40), file = "payu/wordcloud_best")
# 
# tsne_tfidf_df = GetTSNE_TFIDF(data, vz, model_location = 'payu/tsne_tfidf.csv', n_components = 50, n_iter = 500)
# 
# plotTFIDF(tsne_tfidf_df, filename = "payu/2d_plane.png")
# 
# exportTFIDF_HTML(tsne_tfidf_df, filename = 'payu/tfidf.html')
# 
# # GetClustersPerformance(vz, filename = "payu/KMeansGroupTest.png", k_max = 80) # Decide ideal number of clusters
# 
# num_clusters = 30
# kmeans = GetKmeans(vz, num_clusters)
# 
# keywords_df = GetKeywordsKmeans(kmeans, vectorizer)
# 
# kmeans_df = GetKmeansDF(kmeans, data, vz, model_location = 'payu/tsne_kmeans.csv', n_components = 2, n_iter = 500)
# 
# exportKmeansDF(kmeans_df, filename = 'payu/KMeansGraph.html')
# 
# # ---- LDA ----
# 
# corpus, aux, id2word = setCorpusAux(data)
# 
# # Correr solo cuando haya incertidumbre sobre el número óptimo de tópicos. En este ejemplo fueron 40.
# # coherences, models = exploreLDAmodels(df = aux, rg = range(5, 85, 5), filename = "payu/LDA_Topics.png")
# 
# optimal_num_topics = 35 # This should be and input of previus explore_models function
# best_model = LDA_model(num_topics=optimal_num_topics, passes=5)
# display_topics(model = best_model)
# 
# matrix = get_document_topic_matrix(corpus, num_topics=best_model.num_topics)
# 
# lda_df = getLDA_DF(matrix, corpus, data, model_location ='payu/tsne_lda.csv', n_components=2, n_iter=500)
# 
# plotLDA_DF(lda_df, filename = 'payu/LDA_Graph.html')
# 
# exportLDA_vis(best_model, corpus, id2word, filename = 'payu/pyLDAvis.html')
# 
# getNMF(data, vz, num_topics = 35, top_words = 10)
# 
# # ## 5 - Conclusion
# # Different techniques have been used but I'm pretty sure there's plenty of better methods. In fact, one way to extend this tutorial could be to dive in: 
# # - word2vec and doc2vec to model the topics
# # - setting up a robust way to select the number of clusters/topics up front
