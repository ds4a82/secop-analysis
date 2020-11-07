import pandas as pd
import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer
import nltk
#K MEANS
from sklearn.cluster import MiniBatchKMeans, KMeans
from sklearn.metrics import silhouette_score
from sklearn.manifold import TSNE
import matplotlib.pyplot as plt
import warnings
import datetime
warnings.filterwarnings("ignore")
from nltk.corpus import stopwords
nltk.download('stopwords')
# LDA
import gensim
import gensim.corpora as corpora
from gensim import matutils
from gensim.models import CoherenceModel
from gensim.models import wrappers
import pyLDAvis
import pyLDAvis.gensim



df = pd.read_csv(r"6. Viz/shiny/data/secop.csv", encoding='ISO-8859-1')
df=df.dropna()


global stopwords

def GetVZandTFIDF(data):
    stopwords_ = [word.encode('utf-8') for word in stopwords.words('spanish')]
    vectorizer = TfidfVectorizer(
        min_df=5
        , analyzer='word'
        , ngram_range=(1, 2)
        , stop_words=stopwords_)
    vz = vectorizer.fit_transform(list(data["descripcion_del_proceso"]))
    vz.shape
    tfidf = dict(zip(vectorizer.get_feature_names(), vectorizer.idf_))
    tfidf = pd.DataFrame(columns=['tfidf']).from_dict(dict(tfidf), orient='index')
    tfidf.columns = ['tfidf']
    return vz, tfidf, vectorizer

def GetClustersPerformance(vz, filename = "KMeansGroupTest.png", k_max = 80):
    vz.shape
    distorsions = []
    sil_scores = []
    for k in range(2, k_max): # k = 3
        print("Cluster : %s" %(k))
        kmeans_model = MiniBatchKMeans(n_clusters=k, init='k-means++', n_init=1, random_state=42,
                                       init_size=1000, batch_size=35000,verbose=False, max_iter=1000)
        kmeans_model.fit(vz)
        sil_score = silhouette_score(vz, kmeans_model.labels_,sample_size=3000)
        print(f"sil_score:{sil_score}")
        sil_scores.append(sil_score)
        distorsions.append(kmeans_model.inertia_)
        print(f"distorsion:{kmeans_model.inertia_}")
        del(kmeans_model)
    f, (ax1, ax2) = plt.subplots(2, 1, sharex=True, figsize=(25, 20))
    ax1.plot(range(2, k_max), distorsions)
    ax1.set_title('Distorsion vs num of clusters')
    ax1.grid(True)
    ax2.plot(range(2, k_max), sil_scores)
    ax2.set_title('Silhouette score vs num of clusters')
    ax2.grid(True)
    plt.show()
    plt.savefig(filename)
    plt.close()
    return distorsions,sil_scores




def GetKmeans(vz, num_clusters):
    kmeans_model = MiniBatchKMeans(n_clusters=num_clusters, init='k-means++', n_init=1, random_state=42,
                                   init_size=1000, batch_size=35000, verbose=False, max_iter=1000, )
    kmeans = kmeans_model.fit(vz)
    kmeans_clusters = kmeans.predict(vz)
    kmeans_distances = kmeans.transform(vz)
    return kmeans

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

def GetKmeansDF(kmeans, data, vz, n_components = 2, n_iter = 500):
    kmeans_clusters = kmeans.predict(vz)
    kmeans_distances = kmeans.transform(vz)
    tsne_model = TSNE(n_components=n_components, verbose=1, random_state=0, n_iter=n_iter)
    tsne_kmeans = tsne_model.fit_transform(kmeans_distances)
    kmeans_df = pd.DataFrame(tsne_kmeans, columns=['x','y'])
    kmeans_df['cluster'] = kmeans_clusters
    kmeans_df['cluster'] = kmeans_df['cluster'].map(str)
    kmeans_df["descripcion_del_proceso"] = data["descripcion_del_proceso"]
    kmeans_df['id']=data['id']
    kmeans_df.to_csv('Kmeans.csv', index=False, encoding='utf-8')
    return kmeans_df



def sent_to_words(sentences):
    for sentence in sentences:
        yield(gensim.utils.simple_preprocess(str(sentence), deacc=True))  # deacc=True removes punctuations

def setCorpusAux(data):
    data_words = list(sent_to_words(data["descripcion_del_proceso"]))
    data['tokens_bigram']=data_words
    bigram = gensim.models.Phrases(data['tokens_bigram'], min_count=5, threshold=2)
    bigram_mod = gensim.models.phrases.Phraser(bigram)
    data['tokens_bigram'] = data['tokens_bigram'].map(lambda tokens: bigram_mod[tokens])
    id2word = corpora.Dictionary(data['tokens_bigram'])
    texts = data['tokens_bigram'].values
    corpus = [id2word.doc2bow(text) for text in texts]
    print(texts)
    return corpus, id2word

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

def plot_coherences(x, y, filename):
    fig = plt.figure(figsize=(15, 5))
    plt.title('Choosing the optimal number of topics')
    plt.xlabel('Number of topics')
    plt.ylabel('Coherence')
    plt.grid(True)
    plt.plot(x, y)
    plt.savefig(filename)
    plt.close()

def exploreLDAmodels(data, corpus, id2word, topic_range=range(5, 110, 10), filename = "LDA_Topics.png"):
    coherences = []
    X=[]
    Y=[]
    for num_topics in topic_range: # num_topics = 5
        # lda_model = Mallet_model(corpus, id2word, num_topics)
        lda_model = LDA_model(corpus, id2word, num_topics, passes=5)
        perplexity = lda_model.log_perplexity(corpus) # The lower the better
        coherence_model = CoherenceModel(model=lda_model, texts=data['tokens_bigram'].values, dictionary=id2word, coherence='c_v') # The higher the better
        coherence = coherence_model.get_coherence() # The higher the better
        coherences.append(coherence)
        print("LDA Model %s. Number of topics: %s. Coherence: %s. Perplexity: %s" %(datetime.datetime.now().strftime("%d/%m/%Y %H:%M:%S"), num_topics, round(coherence, 3), round(perplexity, 2)))
        X.append(topic_range[0:len(coherences)])
        Y.append(coherences)
        #plot_coherences(x = topic_range[0:len(coherences)], y = coherences, filename = filename)
    return coherences,lda_model,X,Y


def LDA_model(corpus, id2word, num_topics, passes=1, chunksize = 500):
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

def exportLDA_vis(best_model, corpus, id2word, filename = 'pyLDAvis.html'):
    panel = pyLDAvis.gensim.prepare(best_model, corpus, id2word, mds='mmds')
    pyLDAvis.save_html(panel, filename)

def exportKmeansDF(kmeans_df, filename = 'KMeansGraph.html', char_lenght = 200, title="KMeans clustering", plot_width=890, plot_height=600, title = "Plot"):
    from bokeh.palettes import d3
    import bokeh.models as bmo
    from bokeh.models import HoverTool, BoxSelectTool
    from bokeh.plotting import figure, output_file, save
    # from bokeh.embed import file_html
    # from bokeh.resources import CDN
    plot_kmeans = figure(
        plot_width=plot_width
        , plot_height=plot_height
        , title=title
        , tools= "pan,wheel_zoom,box_zoom,reset,hover"
        , x_axis_type=None, y_axis_type=None, min_border=1)
    palette = d3['Category20'][12] + d3['Category20b'][12]
    color_map = bmo.CategoricalColorMapper(
        factors=kmeans_df['cluster'].unique()
        , palette=palette
        )
    plot_kmeans.scatter('x', 'y', source=kmeans_df,
                        color={'field': 'cluster', 'transform': color_map},
                        legend='cluster')
    hover = plot_kmeans.select(dict(type=HoverTool))
    hover.tooltips={"description": "@descripcion_del_proceso", "cluster": "@cluster"}
    output_file(filename, mode='inline', title = title)
    save(plot_kmeans)
    # html = file_html(plot_kmeans, CDN, title)
    # f = open(filename, 'w')
    # f.write(html)
    # f.close()

    # ---- LDA ----

d_ = df.copy()[:100]
vz, tfidf, vectorizer = GetVZandTFIDF(d_)
corpus, id2word = setCorpusAux(d_)
# coherences, models,X,Y = exploreLDAmodels(d_,corpus,id2word, filename = "5. Model/LDA_Topics.png") # When the number is uncertain

# ---- K-Means ----
# dist,sil_scores=GetClustersPerformance(vz, filename = "5. Model/KMeansGroupTest.png", k_max = 30) # K=29
num_clusters = 24
kmeans = GetKmeans(vz, num_clusters)
keywords_df = GetKeywordsKmeans(kmeans, vectorizer)
print(keywords_df)
keywords_df.to_csv('5. Model/Key Topics.csv')
kmeans_df = GetKmeansDF(kmeans, d_, vz,n_components = 2, n_iter = 500)
kmeans_df.to_csv('5. Model/KKmeans.csv')
exportKmeansDF(kmeans_df, filename = '5. Model/KMeansGraph.html')


optimal_num_topics = 15 # This should be and input of previus explore_models function
best_model = LDA_model(corpus,id2word,num_topics=optimal_num_topics, passes=5)
Key_model=display_topics(model = best_model)
Key_model.to_csv('5. Model/Key_Model.csv')
matrix = get_document_topic_matrix(corpus,best_model)
exportLDA_vis(best_model,corpus,id2word, filename = "5. Model/pyLDAvis.html")
