 %% Program to divide the X_data into k chunks

% XindexTest: k cells each of which contain the indexes of test data
% XindexTrain: k cells each of which contain the indexes of training data

% Refer to the cells as XindexTest{1,i}...

% use the above indexes obtained to retrieve rows from the ...
% original X (not including the column of 1's)

% X is length of input matrix (not including 1)
% k is number of chunks
% X_length = number of rows of X
function [XindexTest, XindexTrain]= KStepChunking(X_length, k)
    m= X_length;
    minchunksize=floor(m/k);
    Resulting= cell(1,k);
    for i=1:k;
        Resulting{i}=struct('data',-1*ones(1,minchunksize),'index',0);
    end
    
    for i=1:k*minchunksize
        while true
            putin=randi(k);
            if Resulting{putin}.index <minchunksize
                Resulting{putin}.index=Resulting{putin}.index+ 1;
                Resulting{putin}.data(Resulting{putin}.index)=i;
                break;
            end
        end
    end
    for i=k*minchunksize+1:m
        while true
            putin=randi(k);
            if Resulting{putin}.index <minchunksize+1
                Resulting{putin}.index=Resulting{putin}.index+ 1;
                Resulting{putin}.data=[Resulting{putin}.data i];
                break;
            end
        end
    end
    
    XindexTest=cell(1,k);
    XindexTrain=cell(1,k);
    for i=1:k
        XindexTest{1,i}=Resulting{1,i}.data;
        for j=1:i-1
            XindexTrain{1,i}=[XindexTrain{1,i} Resulting{1,j}.data];
        end
        for j=i+1:k
            XindexTrain{1,i}=[XindexTrain{1,i} Resulting{1,j}.data];
        end
    end
end

