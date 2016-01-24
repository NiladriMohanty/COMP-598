# Classification of abstracts using various supervised machine learning algorithms

This project involves a dataset of 96000 training abstracts from the literature classified as either CS, math, physics, or statistics and 30000 testing abstracts. 

We used a data processing pipeline which includes cleaning datasets by removing stop words, lemmatization (by porter stemmer algorithm), tf-idf vectorizer to create a data dictionary. This feature vector was used in Naive Bayes, k nearest neighbours, and support vector machine to determine the multi-class prediction.
