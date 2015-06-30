%%%%%%%%%%%%%%%%%%%%%%% REGULARIZED LOGISTIC REGRESSION  %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;clc;

AccuracyTest =[];
AccuracyTrain = [];

%%%%%%%% ROWS ARE NUMBER OF EXAMPLES
%%%%%%%% COLUMNS ARE NUMBER OF FEATURES

%%%%%%%%%%%% CALCULATING DECISION BOUNDARY IN TERMS OF WEIGHTS %%%%%%%%

%%%%%%%% INPUT DATA MATRIX %%%%%%%%%
data_com = csvread('newtestcom.csv');
X=data_com;

%%%%%%%%% k-FOLD VALIDATION %%%%%%%%%%
X_length = size(X,1);
k = 10;
[XindexTest, XindexTrain]= KStepChunking(X_length, k);

for fold=1:k
%%%%%%%% INPUT DATASET FOR TRAINING %%%%%%%
    Train = XindexTrain{fold};
    for row=1:length(Train)
        XTrain(row,:) = X(Train(row),:);    
    end

%%%%%%%% OUTPUT LABELS %%%%%%%%
    yTrain=XTrain(:,end); 

%%%%%%%% REMOVING THE OUTPUT LABLES FROM INPUT DATA MATRIX %%%%%%%%%
    XTrain = XTrain(:,1:(end-1));

%%%%%%%%% NORMALIZING THE TRAINING DATASET %%%%%%%%%
    XTrain=normalize(XTrain); 
    
%%%%%%%%% ADDING ONES FOR THE INTERCEPT TERM %%%%%%%%%%
    [nTrainexamples, mTrainfeatures] = size(XTrain); 
    XTrain = [ones(nTrainexamples, 1), XTrain];

%%%%%%%%% INITIALIZE WEIGHTS %%%%%%
    initial_weight = zeros(size(XTrain, 2), 1);

%%%%%%% REGULARIZATION PARAMETER LAMBDA %%%%%%%
    lambda = 1;

%%% NUMBER OF ITERATIONS  %%%%%
    numiter = 1000;

%%%%%%% HYPERPARAMETER ALPHA %%%%%%
    alphaf = 0.00001;

%%%%%%% COMPUTE AND DISPLAY ERROR HISTORY AND WEIGHTS AFTER REGULARIZED LOGISTIC REGRESSION %%%%%%%%
    [weight, err_history] = graddescent(initial_weight, XTrain, yTrain, lambda, alphaf, numiter);

%%%%%%% PLOT HOW ERROR HISTORY CHANGED ACROSS NUMBER OF ITERATIONS %%%%%%%
    plot(1:numiter,err_history);
    xlabel('Number of Iterations');ylabel('Error');
    title('Error function vs Number of Iterations');

% %     result=XTrain*weight;

%%%%%%%%% PREDICTION ON TRAINING DATA %%%%%%%%%
    predictTrain = zeros(nTrainexamples, 1);
    for example=1:nTrainexamples
        if logsig((XTrain(example,:))*weight) >= 0.5
            predictTrain(example) = 1;
        elseif logsig((XTrain(example,:))*weight) < 0.5
            predictTrain(example) = 0;
        end
    end
    
%%%%%%%% PREDICTION ACCURACY ON TRAINING DATA %%%%%%%%%
    AccuracyTrain(fold) = (sum(predictTrain == yTrain)/nTrainexamples)*100;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TESTING WEIGHTS ON TEST DATA %%%%%%%%%%%%

%%%%%%%% INPUT DATASET FOR TRAINING %%%%%%%
    Test = XindexTest{fold};
    for row=1:length(Test)
        XTest(row,:) = X(Test(row),:);    
    end

%%%%%%%% OUTPUT LABELS %%%%%%%%
    yTest=XTest(:,end);

%%%%%%%% REMOVING THE OUTPUT LABLES FROM INPUT DATA MATRIX %%%%%%%%%
    XTest = XTest(:,1:(end-1));

%%%%%%%%% NORMALIZING THE TRAINING DATASET %%%%%%%%%
    XTest=normalize(XTest);
    
%%%%%%%%% ADDING ONES FOR THE INTERCEPT TERM %%%%%%%%%%
    [nTestexamples, mTestfeatures] = size(XTest);
    XTest = [ones(nTestexamples, 1), XTest];

%%%%%%%%% PREDICTION ON TESTING DATA %%%%%%%%%
    predictTest = zeros(nTestexamples, 1);
    for example=1:nTestexamples
        if logsig((XTest(example,:))*weight) >= 0.5
            predictTest(example) = 1;
        elseif logsig((XTest(example,:))*weight) < 0.5
            predictTest(example) = 0;
        end
    end
    
%%%%%%%% PREDICTION ACCURACY ON TESTING DATA %%%%%%%%%
    AccuracyTest(fold) = (sum(predictTest == yTest)/nTestexamples)*100;

end

% ACCURACY OF TRAINING DATA
fprintf('Accuracy on training data = %f\n',mean(AccuracyTrain));

% ACCURACY OF TESTING DATA
fprintf('Accuracy on testing data = %f\n',mean(AccuracyTest));

