Files must be run in this order, in the same workspace:

1. Running bagofwords.R gives term rankings by raw frequency.
2. Running MI.R requires train_output_changed.csv and creates csv files with  term ranks by presence-in-abstract frequency as well as the feature set for the 896 word dictionary created according to top 80th-quantile MI values.
3. Running PclassGterm.R gives the terms chosen by high P(class |term). 