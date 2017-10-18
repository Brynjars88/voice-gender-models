function [ prediction ] = KNN_mah( Test,Data,Target,K )
%KNN function using mahalanobis distance
%   
sig=cov(Data);
inv_sig=sig^(-1);
for i=1:length(Data)
    
    distance(i)=sqrt((Test-Data(i,:))*inv_sig*(Test-Data(i,:))');
    
end
[dist,NNindex] =sort(distance);
 
prediction=mode(Target(NNindex(1:K)));


end

