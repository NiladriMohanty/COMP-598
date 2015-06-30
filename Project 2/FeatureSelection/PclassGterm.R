PcsGterm=csN2000[,2]/(csN2000[,2]+csN2000[,3])
PmathGterm=mathN2000[,2]/(mathN2000[,2]+mathN2000[,3])
PphysGterm=physN2000[,2]/(physN2000[,2]+physN2000[,3])
PstatGterm=statN2000[,2]/(statN2000[,2]+statN2000[,3])

names(PcsGterm)=as.character(csN2000$V1)
names(PmathGterm)=as.character(mathN2000$V1)
names(PphysGterm)=as.character(physN2000$V1)
names(PstatGterm)=as.character(statN2000$V1)

sortedPcsGt2000=sort(PcsGterm,decreasing=TRUE)
sortedPmathGt2000=sort(PmathGterm,decreasing=TRUE)
sortedPphysGt2000=sort(PphysGterm,decreasing=TRUE)
sortedPstatGt2000=sort(PstatGterm,decreasing=TRUE)

third1000=names(N1dots[2001:3000,])

csN3000=matrix(0,1000,5)
mathN3000=matrix(0,1000,5)
physN3000=matrix(0,1000,5)
statN3000=matrix(0,1000,5)

for (i in 1:1000) {
	csN3000[i,]=buildN(names(third1000)[i],1)
	mathN3000[i,]=buildN(names(third1000)[i],2)
	physN3000[i,]=buildN(names(third1000)[i],3)
	statN3000[i,]=buildN(names(third1000)[i],4)
}


PcsGterm=csN3000[,2]/(csN3000[,2]+csN3000[,3])
PmathGterm=mathN3000[,2]/(mathN3000[,2]+mathN3000[,3])
PphysGterm=physN3000[,2]/(physN3000[,2]+physN3000[,3])
PstatGterm=statN3000[,2]/(statN3000[,2]+statN3000[,3])

names(PcsGterm)=as.character(csN3000$V1)
names(PmathGterm)=as.character(mathN3000$V1)
names(PphysGterm)=as.character(physN3000$V1)
names(PstatGterm)=as.character(statN3000$V1)

sortedPcsGt3000=sort(PcsGterm,decreasing=TRUE)
sortedPmathGt3000=sort(PmathGterm,decreasing=TRUE)
sortedPphysGt3000=sort(PphysGterm,decreasing=TRUE)
sortedPstatGt3000=sort(PstatGterm,decreasing=TRUE)


sortedAll=list(sortedPcsGt2000,sortedPmathGt2000,sortedPphysGt2000,sortedPstatGt2000,
sortedPcsGt3000,sortedPmathGt3000,sortedPphysGt3000,sortedPstatGt3000)

Terms80=unlist(sapply(sortedAll,function(x) names(x)[1:sum(x>0.8)]))
Terms70=unlist(sapply(sortedAll,function(x) names(x)[1:sum(x>0.7)]))
Terms60=unlist(sapply(sortedAll,function(x) names(x)[1:sum(x>0.6)]))
Terms50=unlist(sapply(sortedAll,function(x) names(x)[1:sum(x>0.5)]))

termsPHYS80=c(Terms80[[3]],Terms80[[7]])
termsCS70=c(Terms70[[1]],Terms70[[5]])
termsMATH60=c(Terms60[[2]],Terms60[[6]])
termsSTAT50=c(Terms50[[4]],Terms60[[8]])







