Instructions

1. Dataset is in CSV file format.
2. Dataset & all scripts should be in current directory.
3. Run "dribble_features.m" script to extract Hog features from dribble images and save it in a csv format file.
4. Run "dunk_features.m" script to extract Hog features from dribble images and save it in a csv format file.
5. Run "LogisticRegression.m" to start logistic regression algorithm.
	# "KStepChunking.m" is called within LogisticRegression.m for k-fold validation.
	# "normalize.m" is used to normalise input datasets.
	# "graddescent.m" is used for gradient descent method.
		# "costfuncreg.m" calculates the cost (error) fucntion value at each iteration.
6. After completion of "LogisticRegression.m" script, accuracy of training & testing data will get displayed.
7. Other variables like "Error_history" from "LogisticRegression.m" script can be used for producing the 
   "error vs iterations" graph using "Error_plotting.m" script.
