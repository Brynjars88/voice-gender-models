function [ y ] = KNN_cosine( x,X,t,K )
%KNN classifier that uses the cosine
%   Detailed explanation goes here
for i =1:length(X)
    distance(i)=dot(x,X(i,:))/(norm(x)*norm(X(i,:)));
end
[dist,NNindex] =sort(distance);

y=mode(t(NNindex(1:K)));


end

