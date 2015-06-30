function [err] = costfuncreg(weight, X, y, lambda)

%%%%%% LENGTH OF OUTPUT LABELS %%%%%%%%%%
n = length(y);

%%%%%%%%% LOGISTIC FUNCTION/SIGMOID FUNCTION %%%%%%%%%%
logisticfunc = 1 ./ (1 + exp(-(X*weight)));

%%%%%%%%% ERROR FUNCTION %%%%%%%%%%%%
err = - sum(((y .* log(logisticfunc)) + ((1-y) .* log(1-logisticfunc))));

%%%%%%%%% REGULARISED ERROR FUNCTION %%%%%%%%%
err = err + ((lambda)*(sum((weight).^2)));

end
