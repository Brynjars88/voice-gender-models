function y = kNNClassifier(x,X,t,K)
for i =1:length(X)
    distance(i)=norm(x-X(i,:),2);
end
[dist,NNindex] =sort(distance);

y=mode(t(NNindex(1:K)));
