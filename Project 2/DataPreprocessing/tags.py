## script used for tokenizing and tagging words
## input is csv file
import nltk
import csv

## import csv file of abstracts for tokenizing and tagging words
f = open('_______.csv') # input file name
csv_f = csv.reader(f)
abs = []
for row in csv_f:
   abs.append(row)
f.close()

## first tokenizing words
## second selecting particular words from specific part of speech
newabs=[]

## interested part of speech
## 'FW' = Foreign word, 'JJ' = adjective, 'JJR' = adjective, comparative
## 'JJS' = adjective, superlative, 'NN' = noun, singular or mass
## 'NNS' = noun plural, 'NNP' = proper noun, singular, 'NNPS' = proper noun, plural.
interest=['FW','JJ','JJR','JJS','NN','NNS','NNP','NNPS']

## writing pos (part of speech) in a csv file
f=open('_______.csv' , 'w') # output file name

for row in abs:
        tok = nltk.word_tokenize(row[1])
        tags = nltk.pos_tag(tok)
        
        for word,type in tags:
                if type in interest:
                        f.write (word+' ')

        f.write('\n')

f.close()


