function [ M ] = Conf_M( Target, Predict )
%Fall sem býr til Fylki fyrir confusion Töflu.
%   ActualclassXPredictedClass  3x3 fylki
M=zeros(2,2);

for i=1:length(Target)
    
        M(Target(i),Predict(i)) = M(Target(i),Predict(i))+1;
end

