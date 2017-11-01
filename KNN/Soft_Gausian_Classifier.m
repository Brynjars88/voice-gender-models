function [ T ] = Soft_Gausian_Classifier( Mu1,Mu2,sigC1,sigC2,Target)
%Classifier that calculates the probabilty that A point belongs to a
%gaussian for class 0 or class 1
%we use the margin of plus minus 0.5% to calculate the probability that the point
%belongs to each gaussian then pick the one that is more probable
% since we know the probability of each class is 0.5 we dont need to worry about that. 

%done to fix a error if the diagonal of the covariance matrix contains
%values that are too close to zero
sigC1=sigC1+eye(length(sigC1))*0.001;
sigC2=sigC2+eye(length(sigC2))*0.001;
P_C1=mvnpdf(Target+Target.*0.005,Mu1,sigC1)-mvnpdf(Target-0.005.*Target,Mu1,sigC1);
P_C2=mvnpdf(Target+Target.*0.005,Mu2,sigC2)-mvnpdf(Target-0.005.*Target,Mu2,sigC2);


if P_C1<=P_C2
    
    T=0;
else
    T=1;
end

