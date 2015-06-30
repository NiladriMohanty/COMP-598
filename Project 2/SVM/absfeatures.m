function x = absfeatures(word_indices)

n = 1006;
x = zeros(1, n);
 
for i = word_indices,
    x(i) = 1;
end
end
