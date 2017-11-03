load '../data/femaleTraining.mat'
load '../data/maleTraining.mat'

C1 = femaleTraining(:,1:20);
C2 = maleTraining(:,1:20);

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
Sw = Sw + eye(20)*0.0000001;
invSw = inv(Sw);

invSw_by_SB = invSw * SB;

% Finding the eigenvectors
[V,D] = eig(invSw_by_SB);

% The eigenvector with the largest eigenvalue and our selected projection
W = V(:,1);


% Training data projected onto W
PrC1 = C1*W;
PrC2 = C2*W;

MuP1 = mean(PrC1);
MuP2 = mean(PrC2);

V1 = var(PrC1);
V2 = var(PrC2);

% Separation point for projected classes
% S = 

load '../data/voiceTest.mat'







