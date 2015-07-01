#Author: Xinchi Chen
#This program implemented a feed-forward network with back propagation algorithm
#This part is used to get the output from a new dataset 

import numpy as np
import re
import csv

inode=2304
hn=50 #Hidden node number
outnode=1

# Load all training inputs to a python list
train_inputs = []
with open('test_inputs.csv', 'rb') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    next(reader, None)  # skip the header
    for train_input in reader: 
        train_input_no_id = []
        for pixel in train_input[1:]: # Start at index 1 to skip the Id
            train_input_no_id.append(float(pixel))
        train_inputs.append(train_input_no_id) 

#Load the training files
w_in_hide = []
with open('w_in_hide.csv', 'rb') as f0:
    reader = csv.reader(f0, delimiter=',')
    for in1 in reader: 
        in1d = []
        for in1n in in1[0:]:
            in1d.append(float(in1n))
        w_in_hide.append(in1d) 
              
w_hide_out_t = []
with open('w_hide_out.csv', 'rb') as f1:
    reader2 = csv.reader(f1, delimiter=',')
    for in2 in reader2: 
        in2d = []
        for in2n in in2[0:]:
            in2d.append(float(in2n))
        w_hide_out_t.append(in2d) 
w_hide_out=w_hide_out_t[0]        

threshold1_t = []
with open('threshold1.csv', 'rb') as f2:
    reader3 = csv.reader(f2, delimiter=',')
    for in3 in reader3: 
        in3d = []
        for in3n in in3[0:]:
            in3d.append(float(in3n))
        threshold1_t.append(in3d) 
threshold1=threshold1_t[0]        

for line in open('threshold2.csv'):
    line=line.strip() 
    threshold2=float(line)    


#retrieve the total feature number of the dataset
total=len(w_in_hide)

sig1 = np.zeros(hn) #the sigmoid value at hidden layer
sig2 = 0 #the sigmoid value at output layer
o1 = np.zeros(hn) #the summation at hidden layer
o2 = 0 #the summation at output layer

f=open('finalresult.csv','w')  #OUT
print>>f, 'Id,Prediction'

#Apply the input files into the neural network
z=0
for count in range(total):
    z+=1
    inputs=train_inputs[count]
    
    #Calculate the inner product
    for j in range(hn):
        o1[j]=0
        for i in range(inode):
            o1[j]=o1[j]+w_in_hide[i][j]*inputs[i]
        sig1[j]=1/(1+np.exp(-o1[j]-threshold1[j]))
        
    #calculate the summation between 
    o2=0
    for i in range(hn):
        o2=o2+w_hide_out[i]*sig1[i]
    sig2=1/(1+np.exp(-o2-threshold2))
    
    temp=str(z)+','+str(int(round(sig2*9,0)))
    f.write(temp)
    f.write('\n')
    f.flush()
f.close()    
