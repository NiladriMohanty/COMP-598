% Dribble CSV
% Reading image names
datadir = dir('E:\dunk_resized\*.jpg');
fileNames = {datadir.name};

n=1;
% Extracting Image Hog Features
for i=1:1:numel(fileNames)
img = imread(['E:\dunk_resized\',fileNames{n}]);
features = extractHOGFeatures(img,'cellSize',[10,10]);
if n==1
    M = features; 
else
    M = [M;features];   
end

n = n+1;
end

% Writing to csv
Y_Label =zeros(numel(fileNames),1);
Data = [M Y_Label];
csvwrite('E:\dunk_resized.csv',Data);