classed=read.csv("train_output_changed.csv", header=T)
attach(classed)

csIDs=which(category==4)
mathIDs=which(category==2)
physIDs=which(category==3)
statIDs=which(category==1)
IDs=list(csIDs,mathIDs,physIDs,statIDs)

abstracts=read.csv("stemmed.csv",header=T)
abstracts=as.character(abstracts[,1])

N=length(abstracts)

rawfreq=sort(table(allwords),decreasing=TRUE)		#list of all words and their raw frequency
rawfreq=rawfreq[-1]						

T=length(rawfreq)			#number of unique words across all abstracts

alldistinct=unlist(lapply(abstracts,function(x) unique(strsplit(x," ")[[1]])))

N1dots=sort(table(alldistinct), decreasing=TRUE)	#N1dot for all terms by decreasing frequency of presence in abstracts
N1dots=N1dots[-1]

write.csv(N1dots,file="N1dots.csv")


T==length(N1dots)			#Expect this to be TRUE

N11=function(t,c) {		#number of abstracts in class c containing term t
	useID=IDs[[c]]
	num=sum(sapply(distinct[useID],function(x) 1-is.na(match(t,x))))
	num
}

buildN=function(term,c) {
	n11=N11(term,c)
	n10=as.numeric(N1dots[term,])-n11
	n01=Ndot1s[c]-n11
	n00=N-n11-n10-n01
	c(term,n11,n10,n01,n00)
}

top2000=N1dots[1:2000,]


csN2000=matrix(0,1000,5)
mathN2000=matrix(0,1000,5)
physN2000=matrix(0,1000,5)
statN2000=matrix(0,1000,5)

for (i in 1:1000) {
	csN2000[i,]=buildN(names(second1000)[i],1)
	mathN2000[i,]=buildN(names(second1000)[i],2)
	physN2000[i,]=buildN(names(second1000)[i],3)
	statN2000[i,]=buildN(names(second1000)[i],4)
}

MI=function(v) {
	n11=v[1]; n10=v[2]; n01=v[3]; n00=v[4]
	n1dot=n11+n10; ndot1=n11+n01; n0dot=n01+n00; ndot0=n10+n00
	(1/N)*(n11*log2(N*n11/(n1dot*ndot1))+n10*log2(N*n10/(n1dot*ndot0))
		+n01*log2(N*n01/(n0dot*ndot1))+n00*log2(N*n00/(n0dot*ndot0)))
	
}

csMI2000=apply(csN[,2:5],1,function(x) MI(as.numeric(x)))
mathMI2000=apply(mathN[,2:5],1,function(x) MI(as.numeric(x)))
physMI2000=apply(physN[,2:5],1,function(x) MI(as.numeric(x)))
statMI2000=apply(statN[,2:5],1,function(x) MI(as.numeric(x)))


quant=0.8
quant80MI=unique(c(names(top2000)[which(csMI2000>quantile(csMI2000,na.rm=TRUE,probs=quant))],
names(top2000)[which(mathMI2000>quantile(mathMI2000,na.rm=TRUE,probs=quant))],
names(top2000)[which(physMI2000>quantile(physMI2000,na.rm=TRUE,probs=quant))],
names(top2000)[which(statMI2000>quantile(statMI2000,na.rm=TRUE,probs=quant))]))


dictionary=quant80MI

#### Unsupervised weights

#### tf as feature values ####

L1to2=38483
L1to3=57724
L1to4=76966
N=96208

Xdata=matrix(0,N-L1to4+1,length(dictionary))
colnames(Xdata)=dictionary

for (i in 1:(N-L1to4)) {
	relev=intersect(names(rawFreqs[[i]]),dictionary)
	Xdata[i,which(is.element(dictionary,relev))]=as.numeric(rawFreqs[[i]][relev])
}

write.csv(Xdata,file="tfTestByDictionary896.csv")
