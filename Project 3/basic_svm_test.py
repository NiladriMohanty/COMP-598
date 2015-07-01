import numpy as np
import csv


# Load all training inputs to a python list
train_inputs = []
with open('train_inputs.csv', 'rb') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    next(reader, None)  # skip the header
    for train_input in reader: 
        train_input_no_id = []
        for dimension in train_input[1:]:
            train_input_no_id.append(float(dimension))
        train_inputs.append(np.asarray(train_input_no_id)) # Load each sample as a numpy array, which is appened to the python list

# Load all training ouputs to a python list
train_outputs = []
with open('train_outputs.csv', 'rb') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    next(reader, None)  # skip the header
    for train_output in reader:  
        train_output_no_id = int(train_output[1])
        train_outputs.append(train_output_no_id)

test_inputs = []
with open('test_inputs.csv', 'rb') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    next(reader, None)  # skip the header
    for train_input in reader: 
        train_input_no_id = []
        for dimension in train_input[1:]:
            train_input_no_id.append(float(dimension))
        test_inputs.append(np.asarray(train_input_no_id)) # Load each sample as a numpy array, which is appened to the python list

# Convert python lists to numpy arrays
train_inputs_np = np.asarray(train_inputs)
train_outputs_np = np.asarray(train_outputs)
test_inputs_np = np.asarray(test_inputs)

del train_inputs
del train_outputs
del test_inputs

print train_inputs_np
print train_outputs_np
print test_inputs_np

from sklearn import svm

lin_clf = svm.SVC()
lin_clf.fit(train_inputs_np, train_outputs_np)
print 'Done Training.'
results = lin_clf.predict(test_inputs_np)
print 'Writing.'
np.savetxt('test_results.txt', results, '%d')
# Save as numpy array files
# np.save('train_inputs', train_inputs_np)
# np.save('train_outputs', train_outputs_np)
