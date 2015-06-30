clc;
clear all;
close all;

[numbers, text, data]=xlsread('data.xlsx');

[m n]=size(text);
processed_data=cell(m,1);
count=0;

for i=1:m
    contents=text{i,1};
    [newcontents count]=processAbstract(contents,count);
    processed_data{i,1}=newcontents;
end
xlswrite('stemmed_test.xlsx',processed_data);