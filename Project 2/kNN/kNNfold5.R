#Require "tfDataByDictionary896.csv" and "train_output_changed.csv"

#### Unsupervised weights for words (tf)
L1=19241
L2=38483
L3=57724
L4=76966
N=96208

Xdata=as.matrix(read.csv("tfDataByDictionary896.csv",header=T))

classed=read.csv("train_output_changed.csv",header=T)
attach(classed)

#### FUNCTIONS ####

cosDist=function(x,y) {				#Cosine similarity
	sum(x*y)/sqrt(sum(x^2)*sum(y^2)) 
}

kNN=function(y,labeled,k) {			# y is tf vector of unclassified abstract
	distances=apply(labeled,1,function(x) cosDist(x,y))
	NN=order(distances,decreasing=TRUE)[1:k]	#returns indices of k most similar abstracts
	classvote=rep(0,4)
	for (i in 1:4) {
		classvote[i]=sum(distances[NN]*(category[NN]==i))
	}
	#classes=c("stat","math","phys","cs")
	which(classvote==max(classvote))
}

classify=function(test, labeled, k) {
	apply(test,1,function(x) kNN(x,labeled,k))	# returns vector with predicted classes
}		

#### TEST FOLD 5

guesses=classify(Xdata[(L4+1):N,],Xdata[1:L4,],250)
Error=sum(guesses!=category[(L4+1):N])/length((L4+1):N)
Error

