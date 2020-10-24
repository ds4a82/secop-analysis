# -*- coding: utf-8 -*-
import pandas as pd
import numpy as np
import os
import sys

path = "/home/camilo/Fidelio/PayU/Mapping/"
tables = "source/Tables/Mapping Tables.xlsx"
os.chdir(path)
sys.path.insert(0, '/home/camilo/CRISP-DM/Python/')
from GetWordCloud import GetWordCloud
from GetWordCloud import WordCloudFromDF
from clean_text import clean_text


# ---- Word Clouds From Tables ----
def iterateWordClouds():
  cloudfolder  = "main_img/WordClouds/" 
  sheets = ['Companies', 'Founders', 'VC', 'Events', 'Institutions']
  wordcloud_columns = ['Description', 'About', "Detailed_Description", "ShortDescription"]
  
  # Get Text Columns's WordClouds
  for sheet in sheets: # sheet  = "Founders"
    d = pd.read_excel(io = path + tables, sheet_name = sheet)
    for column in wordcloud_columns: # column = "Description"
      print("%s: %s" %(sheet, column))
      if column in d.columns: # 
        # Filter those without description
        filename = "%s%s %s.png" %(cloudfolder, sheet, column)
        d[column] = d[column].apply(lambda x: " ".join(clean_text(x)) if type(x) is str else None)
        text = d[~d[column].isnull()][column]
        text = " ".join(text.values)
        if(sheet == "Companies"):
          text = text.replace("product","").replace("servic", "").replace("compani", "")
        elif(sheet == "Founders"):
          text = text.replace("founder","").replace("cofound", "")
        GetWordCloud(text, filename, width = 890, height = 420)
  
# iterateWordClouds()


# ---- Companies Content Clustering ----

# ¡PYTHON 2!
path = "/home/camilo/Fidelio/PayU/Mapping/"
tables = "source/Tables/Mapping Tables.xlsx"
tweets_file = path + "source/Scraper/Twitter Scraper/profile.csv"
file = path + "source/Content/%s"
column = "description"
import os
import pandas as pd
import sys

sys.path.insert(0, '/home/camilo/CRISP-DM/Python/Topic Modelling/')
from topicmodelling import *

sys.path.insert(0, '/home/camilo/CRISP-DM/Python/')
from GetWordCloud import WordCloudFromDF
from StoreVariables import *

os.chdir(file %(""))



data = pd.read_excel(io = path + tables, sheet_name = "Companies")
data = data[["twitter_account", "HVM_twi_category"]]
data = data[~data["twitter_account"].isnull()]
data.columns = ["account", "category"]

tweets = pd.read_csv(tweets_file)
tweets = tweets[['account', "content"]]

data = pd.merge(data, tweets, how='inner', on="account")
data[~data["category"].isnull()].reset_index(inplace = True)
data.columns = ['id', 'category', 'description']
data = data[~pd.isnull(data['description'])]
data.loc[pd.isnull(data['category']), 'category'] = "Unassigned"
del(tweets)

data[column] = data[column].map(lambda x: x.replace("RT ", ""))
data[column] = data[column].map(lambda x: x.replace("amp ", ""))
data = data[data[column].map(lambda x: (len(x) < 50000) & (len(x) > 4000))]
exportWordHistogram(data, column, filename = "histogram.png")

data = data.sample(n = len(data)/1.5) # Data is too heavy!
data.reset_index(inplace = True)

data = prepareData(data, column = "description")

# data = load("data_tokenized")
# data = pd.DataFrame(data)
# 
# # top = get_top_keywords_per_category(data)
vz, tfidf, vectorizer = GetVZandTFIDF(data)

# plotCategories(data, column = "category", filename = "categories.png")
# exportHistogramLTIDF(tfidf, filename = file %("histogram_tfidf.png"))

# ---- Word Clouds From Tweets ----
# WordCloudFromDF(data.sample(100), column, filename = "TweetWordCloud.png")
# plot_word_cloud(tfidf.sort_values(by=['tfidf'], ascending=True).head(50), filename = "TweetWordCloudLeast.png")
# plot_word_cloud(tfidf.sort_values(by=['tfidf'], ascending=False).head(50), filename = "TweetWordCloudBest.png")

# ---- TF-IDF ----
# tsne_tfidf_df = GetTSNE_TFIDF(data, vz, model_location = file %('tsne_tfidf.csv'), n_components = 50, n_iter = 500)
# plotTFIDF(tsne_tfidf_df, filename = file %("2d_plane.png"))
# exportTFIDF_HTML(tsne_tfidf_df, filename = file %('tfidf.html'), char_lenght = 200)

# ---- K-Means ----
# # GetClustersPerformance(vz, filename = file %("KMeansGroupTest.png"), k_max = 80) # Decide ideal number of clusters
# num_clusters = 40
# kmeans = GetKmeans(vz, num_clusters)
# keywords_df = GetKeywordsKmeans(kmeans, vectorizer)
# kmeans_df = GetKmeansDF(kmeans, data, vz, model_location = file %('tsne_kmeans.csv'), n_components = 2, n_iter = 500)
# exportKmeansDF(kmeans_df, filename = file %('KMeansGraph.html'))

# ---- LDA ----
# corpus, aux, id2word = setCorpusAux(data)
# # coherences, models = exploreLDAmodels(df = aux, rg = range(20, 60, 5), filename = "LDA_Topics.png")
# save((corpus, id2word), "corpus")
corpus, id2word = load("corpus")

optimal_num_topics = 40 # This should be an input of previus explore_models function
# best_model = LDA_model(corpus, id2word, optimal_num_topics, passes=5)
# save(best_model, "best_model")
best_model = load("best_model")
display_topics(model = best_model)

exportLDA_vis(best_model, corpus, id2word, filename = 'pyLDAvis.html')


lda_df = getLDA_DF(model_location ='tsne_lda.csv', n_components=2, n_iter=500)
plotLDA_DF(lda_df, filename = 'LDA_Graph.html')

getNMF(data, vz, num_topics = optimal_num_topics, top_words = 10)



