
#Require "tfDataByDictionary896.csv" and "train_output_changed.csv"
setwd(#### DIRECTORY PATH HERE ####)

#### Unsupervised weights for words (tf)
L1=19241
L2=38483
L3=57724
L4=76966
N=96208

Xdata=as.matrix(read.csv("tfDataByDictionary896.csv",header=T) [-(L4+1):N,])

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
		classvote[i]=distances[NN]%*%(category[NN]==i)
	}
	#classes=c("stat","math","phys","cs")
	which(classvote==max(classvote))
}

classify=function(test, labeled, k) {
	apply(test,1,function(x) kNN(x,labeled,k))	# returns vector with predicted classes
}		


#### Cross-valid for determining best k ####



K=seq(5,30,5)

foldIDs=list(1:L1,(L1+1):L2,(L2+1):L3,(L3+1):L4)
ERR=matrix(0,4,length(K))

for (i in 1:4) {
    ERR[i,]=sapply(K, function(k) {
			valid=Xdata[foldIDs[[i]],]
			train=Xdata[-foldIDs[[i]],]
			guesses=classify(valid,train,k) 
			error=sum(guesses!=category[foldIDs[[i]]])/length(foldIDs[[i]])
			error
			}
		)
}

plot(K,colMeans(ERR))		#Average misclassification rate
