%%
clear all; clc; close all;

%% changed output labels
%%%% low=1   medium=2   high=3
%%
% % % [num text dict] = xlsread('800words.xlsx');% read vocabulary dictionary usually column vector 

[num text dict] = xlsread('dict.csv'); %input dictionary either 800 words, 1006 words or 1664 words

[num2 text2 stem_in] = xlsread('stemmed.csv'); %input abstracts (stemmed abstracts) 

[tr_op text3 num3] = xlsread('train_output_changed.csv'); %output labels file


%% generating feature vector

for i= 2:10%size(stem_in,1)
    for j = 1:10%size(dict,1)
        match = strcmp(dict{j,1}, regexp(stem_in{i},' ', 'split'));
        if match >= 1
            feature_vect(i-1,j) = 1;
        end
        %find(match);%informs how many times a particular word appears in 1 abstarct/example
    end
end
%% generating feature vector
% informs how many times a particular word appears in 1 abstarct/example

for i= 2:size(stem_in,1)
    for j = 1:size(dict,1)
        match = strcmp(dict{j,1}, regexp(stem_in{i},' ', 'split'));
        feature_vect(i-1,j) = length(find(match));       
    end
end
%%
k_op = tr_op(1:3750,1); % training dataset
%% calculating p(y=k) and p(y=k')
for r = 1:3
    cla = find(k_op==r);
   
    py1(r,1) = length(cla)/length(k_op);

    pya(r,1) = 1-py1(r,1);
end

%%                                 TRAINING
%%% preparing a matrix of p(x/y=one class) considering each class at a time
%%% preparing a matrix of p(x/y=all remaining class)

    for r = 1:3
        pxy1(r,:) = sum(feature_vect((k_op==r),:),1);
        pxya(r,:) = sum(feature_vect((k_op~=r),:),1);
        
        pxy1f(r,:) = (pxy1(r,:) + 1)./ (length(feature_vect(k_op==r)) + 2); 
        pxyaf(r,:) = (pxya(r,:) + 1)./ (length(feature_vect(k_op~=r)) + 2);

    end
    
%%% pxy1f = 4 X length of dictionary
%%% pxyaf = 4 X length of dictionary
%%% py1 = 4 X 1
%%% pya = 4 X 1

 %%                                 VALIDATION

val_feat = feature_vect(3751:5368,:); % validation dataset

for ex = 1:size(val_feat,1)
    for cla = 1:size(pxy1f,1)

            op_pxy1 = prod(pxy1f(cla,:) .^ val_feat(ex,:) .* (1-pxy1f(cla,:)) .^ (1-val_feat(ex,:)));                    
            op_pxya = prod(pxyaf(cla,:) .^ val_feat(ex,:) .* (1-pxyaf(cla,:)) .^ (1-val_feat(ex,:)));

            op_pyx(cla,1) = (op_pxy1 * py1(cla,1))  / (op_pxy1 + op_pxya);

    end      
    [M op_cla] = max(op_pyx(:));

    predictVal(ex,1) = op_cla;

       
end

 yVal(:,1) = tr_op(3751:5368,1); %output for validation
 AccuracyTest = (sum(predictVal == yVal)/length(yVal))*100