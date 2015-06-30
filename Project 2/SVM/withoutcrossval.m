clc;
clear all;
close all;

%%% reading abstracts for stemming and converting each abstract to a
%%% vector of features

%[num1 data1 raw1]=xlsread('test_input.csv');
%dict=load('dictfinal.mat');
%dict=dict.dict;

%data1=data1(2:size(data1,1),2);

%[m n]=size(data1);
%Xtest=zeros(m,size(dict,1));
%count=0;

%for i=1:m
 %   contents=data1{i,1};
 %  [word_indices count]=processAbstract_WI(contents,count,dict);
 %  Xtest(i,:)=absfeatures(word_indices);
%end

%[n1 ytrain r1]=xlsread('train_output.csv');
%ytrain=ytrain(2:size(ytrain,1),2);
%ytrain=strrep(ytrain,'physics','2');
%ytrain=strrep(ytrain,'cs','1');
%ytrain=strrep(ytrain,'math','3');
%ytrain=strrep(ytrain,'stat','4');
%ytrain=cell2mat(ytrain);
%ytrain=str2num(ytrain);

x=load('Xtrainfinal.mat');
xtrain=x.Xtrain;
y=load('ytrain.mat');
ytrain=y.ytrain;
[m n]=size(x);



xtest=load('Xtestfinal.mat');
xtest=xtest.Xtest;

ytest=load('ytest.mat');
ytest=ytest.ytest;

DM=zeros(4, size(xtest,1));

for i=1:4
    for j=i+1:4
    inij=(ytrain==i) | (ytrain==j);
    xtrainij=xtrain(inij,:);
    ytrainij=ytrain(inij,:);
    model= svmtrain(ytrainij, xtrainij);
    outlabel=svmpredict(ytest,xtest,model);
    
    rowin=outlabel;
    colin=(1:1:size(xtest,1))';
    
    linearInd=sub2ind([4 size(xtest,1)], rowin, colin);
    
    DM(linearInd)=DM(linearInd)+1;
    end
    disp(i);
end

[~,outlabel]=max(DM);
accuracy=mean(outlabel'==ytest);
disp(accuracy);




        