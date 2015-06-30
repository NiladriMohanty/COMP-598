This folder contains the following files-

1.	SVmwithcrossval.m
2.	withoutcrossval.m
3.	Xtrain.mat
4.	Xtrain999.mat	
5.	Xtrain1664.mat
6.	Xtrainfinal.mat
7.	Xtest.mat
8.	Xtest999.mat
9.	Xtest1664.mat
10.	Xtestfinal.mat
11.	ytrain.mat
12.	ytest.mat
13.	processAbstract_WI.m
14.	Porterstemmer.m
15.     dict.mat (dict of 1006 words)
16.     dict999.mat (dict of 999 words)
17.     dictexpanded.mat (dict of 2007 words)

1. SVMwithcrossval.m
contains MATLAB code to clasify the dataset using SVM with "K fold Cross validation."

2. withoutcrossval.m
contains MATLAB code to classify the dataset without cross-validation. This code uses a constant value of C and sigma. C=10, sigma=0.015
This code was mainly written to expedite the performance of different dictionaries.

3. Xtrain.mat
contains feature vectors computed from dictionary of length 1006.

4. Xtrain999.mat
contains feature vectors computed from dictionary of length 999.

5. Xtrain1664.mat
contains feature vectors computed from dictionary of length 1664.

6. Xtrainfinal.mat
contains feature vectors computed from dictionary of length 2007.

7. Xtest, Xtest999, Xtest1664, Xtestfinal-
contains features vectors computed for different dictionary lengths.

8. ytrain.mat
contains labels for training data

9 ytest.mat
contains labels for test data.

10. absfeatures
function for feature vector computation.

11. Porterstemmer.m
function for stemming algorithm

12. processAbstract_WI.m
function takes abstract file. After removing stop words, call Porterstemmer.m file

PS- PLEASE MAKE SURE TO LOAD APPROPRIATE .MAT FILES BEFORE RUNNING THE 
ALGORITHM FROM 1ST OR 2ND FILE. DEPENDING ON THE VALUE OF NUMBER OF 
COLUMNS OF TRAINING DATA, CHANGE THE VALUE OF "n" IN "absfeatures.m" file.
