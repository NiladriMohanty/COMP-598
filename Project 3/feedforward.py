#Author: Xinchi Chen
#This program implemented a feed-forward network with back propagation algorithm 

import numpy as np
import re
import csv


inode=2304
hn=10 #hidden nodes = 10
outnode=1

# Load all training inputs to a python list
train_inputs = []
with open('trainin.csv', 'rb') as csvfile:
# with open('test.csv', 'rb') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    next(reader, None)  # skip the header
    for train_input in reader: 
        train_input_no_id = []
        for pixel in train_input[1:]: # Start at index 1 to skip the Id
            train_input_no_id.append(float(pixel))
        train_inputs.append(train_input_no_id) 

# Load all training ouputs to a python list
train_outputs = []
with open('trainout.csv', 'rb') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    next(reader, None)  # skip the header
    for train_output in reader:  
        train_output_no_id =  int(train_output[1])
        train_outputs.append(train_output_no_id)

#retrieve the total feature number of the dataset
total=len(train_inputs)

#learning rate for 
lr_in_hide=0.7; #learning rate for the weights between input layer and hidden layer
lr_hide_out=0.7; #learning rate for the weights between hidden layer and output layer
lr_hide_sigmoid=0.7; #learning rate for the sigmoid output of hidden layer
lr_out_sigmoid=0.7; #learning rate for the sigmoid output of output layer

#value initialization            
w_in_hide = np.random.rand(2304,50)-1 #the weight between input layer and hidden layer
w_hide_out = np.random.rand(hn)-1 #the weight between hidden layer and output layer
threshold1=np.random.rand(hn)-1 #the sigmoid value of hidden layer
threshold2=(np.random.rand(1))[0]-1 #the sigmoid value of output layer
adjust2 = np.zeros(hn) #the adjust value between input layer and hidden layer
adjust1 = 0 #the adjust value between hidden layer and output layer
normal_out = 0 #normalize the output value into the interval [0,1]
inputs = np.zeros(inode) #the array for input values
sig1 = np.zeros(hn) #the sigmoid value at hidden layer
sig2 = 0 #the sigmoid value at output layer
o1 = np.zeros(hn) #the summation at hidden layer
o2 = 0 #the summation at output layer

def sup(hi):

    global error
    global e
    global w_in_hide
    global w_hide_out
    global threshold1
    global threshold2
    global adjust2
    global adjust1
    global normal_out
    global inputs
    global sig1
    global sig2
    global o1
    global o2

    e=0.0;

    for count in range(total):
        inputs=train_inputs[count]
        real_out=train_outputs[count]
        normal_out=real_out*0.11111111111111111111
        
        #Phase I
        for j in range(hn): #1-10
            o1[j] = np.inner(w_in_hide[i], inputs)
            sig1[j]=1/(1+np.exp(-o1[j]-threshold1[j]))
            
        #calculate the summation between 
	o2 = np.inner(w_hide_out, sig1)
        
        sig2=1/(1+np.exp(-o2-threshold2))
            
		#the adjust value is calculated by the (difference between estimated output and true output)*(derivative of sigmoid function)
        adjust1=(normal_out-sig2)*sig2*(1-sig2)
		#apply the adjust value to the weights between hidden layer and output layer
        for i in range(hn):
            w_hide_out[i]+=lr_hide_out*adjust1*sig1[i]
    
        #back-propagate the adjust value to input layer and hidden layer
        for j in range(hn):
	    #new adjust value(named adjust2) between input layer and hidden layer
            adjust2[j]=adjust1*w_hide_out[j]
            adjust2[j]=adjust2[j]*sig1[j]*(1-sig1[j])
            
			#apply the adjust2 value to the weights between input layer and hidden layer
            for i in range(inode):
                w_in_hide[i][j]+=lr_in_hide*adjust2[j]*inputs[i]
        
        #Phase V
        #calculate the square error of all outputs
        e += (normal_out-sig2)*(normal_out-sig2)
        error= e / 2.0
        
        #Phase VI
        threshold2=threshold2+lr_out_sigmoid*adjust1
        for i in range(hn):
            threshold1[i]=threshold1[i]+lr_hide_sigmoid*adjust2[i]

#Testing			
for n in range(10000):
    print n
    sup(0)
    print "e:"+str(e)
    print "adjust1:"+str(adjust1)
    print "sig2:"+str(sig2)
