function [ Y ] = G_predict( training,Test,Target,type )
% prediction function using diffrent classifiers that are derived from
% diffrent assumptions 
% ASsumes two classes with the same probabilty
%type denotes what classifier we want to use.
% soft for soft,M_dist for minimum distance, B_input for gaussian input
C0=find(Target==0);
C1=find(Target==1);

Mu1=mean(training(C0,1:end));
Mu2=mean(training(C1,1:end));
sig1=cov(training(C0,1:end));
sig2=cov(training(C1,1:end));
if strcmp('soft',type)
for i=1:length(Test)
    Y(i)=Soft_Gausian_Classifier(Mu1,Mu2,sig1,sig2,Test(i,:));
    
end
elseif strcmp('M_dist',type) 
    for i=1:length(Test)
    Y(i)=M_Distance(Mu1,Mu2,Test(i,:));
    end
elseif strcmp('B_input',type)
    for i=1:length(Test)
    Y(i)=Bayes_Gaussian(Mu1,Mu2,sig1,sig2,Test(i,:));
    end

end

