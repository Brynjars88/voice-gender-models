load '../data/femaleTraining.mat'
load '../data/maleTraining.mat'

C1 = femaleTraining(:,1:20);
C2 = maleTraining(:,1:20);

[W,b,mu1,mu2,v1,v2] = LDA(C1,C2);

s1 = v1*v1;
s2 = v2*v2;

% Assume Gaussian distribution of data onto one dimension W.
% Confusion matrix for training data

CM1 = zeros(2);

for i=1:size(C1,1)

    y = W'*C1(i,:)';
    
    if normpdf(y,mu1,s1) >= normpdf(y,mu2,s2)
        CM1(1,1) = CM1(1,1) + 1;
    else
        CM1(2,1) = CM1(2,1) + 1;
    end
    
end

for i=1:size(C2,1)

    y = W'*C2(i,:)';
    
    if normpdf(y,mu2,s2) >= normpdf(y,mu1,s1)
        CM1(2,2) = CM1(2,2) + 1;
    else
        CM1(1,2) = CM1(1,2) + 1;
    end
    
end 

load '../data/voiceTest.mat'

% We classify with prior probabilities given two Gaussians in one dimension
targets = test(:,21)';
test = test(:,1:20);
% Project test data onto W
Y = W'*test';
% Prediction of classes for points in Y
predictions(1:length(Y)) = 0;

CM2 = zeros(2);

C1_val = 0;
C2_val = 1;

for i=1:length(Y)
    % b is the boundary point after projection
    if Y(i) <= b
        if targets(i) == C1_val
            CM2(1,1) = CM2(1,1) + 1;
        else
            CM2(2,1) = CM2(2,1) + 1;
        end
    else
        if targets(i) == C2_val
            CM2(2,2) = CM2(2,2) + 1;
        else
            CM2(1,2) = CM2(1,2) + 1;
        end
    end
end





