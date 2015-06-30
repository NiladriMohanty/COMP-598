clc;
clear all;
close all;

%%% reading abstracts for stemming and converting each abstract to a
%%% vector of features

%[num1 data1 raw1]=xlsread('train_inputnew.csv');
%data1=data1(2:size(data1,1),2);

%[o p]=size(data1);
%Xtrain=zeros(m,size(dict,1));
%count=0;

%for i=1:m
 %   contents=data1{i,1};
 %   [word_indices count]=processAbstract_WI(contents,count,dict);
  %  Xtrain(i,:)=absfeatures(word_indices);
%end

%[n1 ytrain r1]=xlsread('train_output.csv');
%ytrain=ytrain(2:size(ytrain,1),2);
%ytrain=strrep(ytrain,'physics','2');
%ytrain=strrep(ytrain,'cs','1');
%ytrain=strrep(ytrain,'math','3');
%ytrain=strrep(ytrain,'stat','4');
%ytrain=cell2mat(ytrain);
%ytrain=str2num(ytrain);

%% Please refer to README.txt to load appropriate .mat files for different dictionary lengths
%make sure to change the value of n to the size of dictionary in
%absfeatures.m file
% the below code is written for a dictionary of length 1006 and I have
% already changed the value of n for this particular case.

dict=load('dict.mat');
dict=dict.dict;
x=load('Xtrain.mat');
x=x.Xtrain;
y=load('ytrain.mat');
y=y.ytrain;
[m n]=size(x);
z=load('Xtest.mat');
xtest=z.Xtest;
w=load('ytest.mat');
ytest=w.ytest;

%% separating training and Validation sets

[Train Val]= crossvalind('Holdout', y, 0.4);
 
xtrain=x(Train,:);
xval=x(Val,:);
 ytrain=y(Train);
yval=y(Val);
 
DM=zeros(4, size(ytest,1));

%% ONE VS ONE APPROACH
for i=1:4
    for j=i+1:4
    inij=(ytrain==i) | (ytrain==j);
    xtrainij=xtrain(inij,:);
    ytrainij=ytrain(inij,:);
    
    inij2=(yval==i)|(yval==j);
    xvalij=xval(inij2,:);
    yvalij=yval(inij2,:);
    
    %%%k fold cross validation
     bestcv = 0;
for log2c = -2:2:4
  for log2g = -6:-4
    cmd = ['-q -v 5 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
    cv = svmtrain(yvalij, xvalij, cmd);
    if (cv >= bestcv),
      bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
    end
  end
  fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n',...
      log2c, log2g, cv, bestc, bestg, bestcv);
end
    
    cmd1=strcat('-q -c',{' '}, num2str(bestc),{' '},'-g',{' '},...
        num2str(bestg));
       
    model= svmtrain(ytrainij, xtrainij,cmd1);
    outlabel=svmpredict(ytest,xtest,model);
    
    rowin=outlabel;
    colin=(1:1:size(ytest,1))';
    
    linearInd=sub2ind([4 size(ytest,1)], rowin, colin);
    
    DM(linearInd)=DM(linearInd)+1;
    end
    disp(i);
end

%% PEFORMANCE
[~,outlabel]=max(DM);
accuracy=mean(outlabel'==ytest);
disp(accuracy);




        