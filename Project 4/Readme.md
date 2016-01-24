# Smart System for Restaurant Rating

Ever got confused by reading Hotels reviews??? 
Was your Dining experience marred by fake reviews on recommending websites???
Was the food tasty but Restaurant Unhygienic??

Our learning algorithm aims to consider all these parameters while rating a Restaurant. There are numerous parameters that influence views for a particular restaurant. There is a plethora of comments and reviews on a Hotels and restaurants but most of them are consumer driven. Although recommending websites are now using algorithms to detect fake and misguiding reviews, very few have managed to highlight the food inspector comments in their recommendation system.

We have incorporated the ratings and reviews given by food inspectors in our algorithm to generate a Restaurant Recommendation systems. The raw data was courteously provided by "Portail donnees ville Montreal". Based on this data, we have made recommendations on how to improve the data collection procedure in Montreal for optimum outcomes.

We wish to have a system in MONTREAL similar to "Health score" as introduced by yelp in San Francisco.

For this project, we downloaded San Francisco data using Yelp API and Montreal data from the Montreal Open Data Portal. 
We used a pipeline of data processing. We used tfidf features with naive bayes and SVM classifier to predict the restaurant ratings.
