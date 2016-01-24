# Movement Detection algorithm

Scrapped thousands of basketball images using different search engines (google, bing, yahoo etc). Classified into 2 categories, Dribbling and Dunking using Logistic Regression.

There are many feature descriptor in the literature that has been used for object detection. We used the histogram of oriented gradients (HOG) to classify different actions in the basketball game. 

This feature gives information about the shape of an object in an image in terms of intensity gradients. HOG gives local geometric transformation information that's why it has been used for detecting movement of pedestrians. 

We used HOG features with regularized Logistic Regression on basketball images to detect their action (movement) category. We classified different categories of basketball actions.

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
