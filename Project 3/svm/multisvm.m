function [result] = multisvm(traininputs,Prediction,testtnputs)

numClasses = 10;
outputClasses = [0:1:9]';

for k=1:numClasses
    G1vAll=(Prediction == outputClasses(k));
    models(k) = svmtrain(traininputs,G1vAll);
end

result = zeros(size(testtnputs,1),1);

for j=1:size(testtnputs,1)
    for k=1:numClasses
        if(svmclassify(models(k),testtnputs(j,:))) 
            result(j) = k;
            break;
        end
    end
    
end