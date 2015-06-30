function [Xnorm]= normalize(X)
%%%%%%% NORMALISING FEATURES %%%%%%%%
%%%%%%% NORMALISE = (X - Xmin) / (Xmax - Xmin) %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    minn=min(X,[],2);
    maxx=max(X,[],2);
    ooo=ones(1,size(X,2));
    Xnorm=(X-minn*ooo)./((maxx-minn)*ooo);
    
end
