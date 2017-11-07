function [W,b,mu1,mu2,v1,v2] = LDA(C1,C2)

no_features = size(C1,2);

% Means
Mu1 = mean(C1)';
Mu2 = mean(C2)';

% Covariance matrices
S1 = cov(C1);
S2 = cov(C2);

% Within-class scatter matrix
Sw = S1 + S2;

% Between-class scatter matrix
SB = (Mu1-Mu2)*(Mu1-Mu2)';

% Computing the LDA projection
Sw = Sw + eye(no_features)*0.0000001;
invSw = inv(Sw);

invSw_by_SB = invSw * SB;

% Finding the eigenvectors
[V,~] = eig(invSw_by_SB);

% The eigenvector with the largest eigenvalue and our selected projection
W = V(:,1);

% Training data projected onto W
PrC1 = C1*W;
PrC2 = C2*W;

mu1 = mean(PrC1);
mu2 = mean(PrC2);

v1 = var(PrC1);
v2 = var(PrC2);

% Separation/boundary point for projected classes

b = (mu1+mu2)/2;

end







