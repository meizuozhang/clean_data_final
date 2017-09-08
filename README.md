# clean_data_final
final project for Clean data 


Package "reshape2" is needed to run the script.

Specifically, the script works through the following steps: 
1. read both datasets for training/test separately as tables, while using the features.txt to assign the variable names; 
2. combine the feature variable training sets; 
3. Extact the mean and standard deviation variables. Note: do not include the meanfrequency
4. Combine the activity label datasets for both training/test, then assign the the specific activity names to the relevant lables;
5. Combine the activity with the mean/sd variables; 
6. reshape the data through melt and dcast to demonstrate the tidy-data. 


