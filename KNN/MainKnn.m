
load '../data/voiceTest.mat'
load '../data/voiceTrain.mat'

K=round(sqrt(length(training)),0);

for i=1:length(test)
    Y(i)=kNNClassifier(test(i,1:20),training(:,1:20),training(:,21),K);
  
end
Target=test(:,21);
Err=ErrorRate(Y,Target);

    test_N=Norm_Matrix(test);
    training_N=Norm_Matrix(training);
    
for i=1:length(test)
    Y_N(i)=kNNClassifier(test_N(i,1:20),training_N(:,1:20),training(:,21),K);
end

Err_normed=ErrorRate(Y_N,Target);


%for i=1:length(test)
%    Ym(i)=KNN_mah(test(i,1:20),training(:,1:20),training(:,21),K);
%    Ym_n(i)=KNN_mah(test_N(i,1:20),training_N(:,1:20),training(:,21),K);
%end

%Err_mah=ErrorRate(Ym,Target);
%Err_mah_normed=ErrorRate(Ym_n,Target);

%for i=1:length(test)
%    Yc(i)=KNN_cosine(test(i,1:20),training(:,1:20),training(:,21),K);
%    Yc_n(i)=KNN_cosine(test_N(i,1:20),training_N(:,1:20),training(:,21),K);
%end
%Err_Co=ErrorRate(Yc,Target);
%Err_Co_normed=ErrorRate(Yc_n,Target);

opt=training;
opt_test=test;
A=corrcoef(training(:,1:20));
[N, M] =size(A);
Z=[];
for i=1:N
    j=i+1;
        for j=i+1:M
            if A(i,j)>0.95
              Z=[Z j];
            end            
        end
    if length(Z)>0
        A=corrcoef(opt);
        [N, M] =size(A);
    end
    opt(:,Z)=[];
    opt_test(:,Z)=[];
    Z=[];
end
test_N_opt=Norm_Matrix(opt);
train_N_opt=Norm_Matrix(opt_test);
for i=1:length(test)
    Y_opt(i)=kNNClassifier(opt_test(i,:),opt,training(:,21),K);
    Y_opt_N(i)=kNNClassifier(test_N_opt(i,:),train_N_opt,training(:,21),K);
end
Target=test(:,21);
Err_opt=ErrorRate(Y_opt,Target);
Err_opt_N=ErrorRate(Y_opt_N,Target);

