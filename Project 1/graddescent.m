function [weight, err_history] = graddescent(weight, X, y, lambda, alphaf, numiter)
%%%%%%% CALCULATES GRADIENT DESCENT %%%%%%%%%%%%%%%
%%%%%%% KEEPS A HISTORY OF ERROR FOR ALL ITERATIONS %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% INITIALSING AN EMPTY MATRIX TO KEEP TRACK OF ERROR HISTORY %%%%%%
err_history = [];

%%%%%% LENGTH OF OUTPUT LABELS %%%%%%%%%%
n = length(y);

%%%%%%% INITIALISING VECTOR OF ZEROS TO GRADIENT %%%%%%%%%
grad = zeros(size(weight)); 

for i =1:numiter

%%%%%%%%%%%%%% LOGISTIC FUNCTION/SIGMOID FUNCTION %%%%%%%%%%%%%
    logisticfunc = 1./(1+exp(-(X*weight))); 

%%%%%%%%%%%%%% GRADIENT %%%%%%%%%%%%%%%%
    grad = (X'*(logisticfunc-y));
    
%%%%%%%%%%%%% REGULARIZATION TERM %%%%%%%%%%%%%
    grad = grad + ((lambda) * weight);
    
% % alpha = alphaf/i;

%%%%%%%%%%%% MULTIPLYING ALPHA(HYPERPARAMETER) TO GRADIENT
    grad = alphaf * grad;
     
%%%%%%%%%% UPDATING THE WEIGHTS %%%%%%%%%
    new_weight = weight - grad;
    weight = new_weight;    

%%%%%%%%%% DETERMINE ERROR FOR NEW WEIGHTS %%%%%%%%%%%
    [err] = costfuncreg(weight, X, y, lambda);
    
%%%%%%%%% SAVE ERROR EVERYTIME %%%%%%%%%%%%%%
    err_history(i) = err;
end

end