load voiceTrain
n=10;
data=Norm_Matrix(training(:,1:20));
[u,v]=pca(data);
F=20;
P_RF2=zeros(F,2);
P_NN=zeros(F,2);
P_NN2=zeros(F,2);
P_svmg=zeros(F,2);
P_svml=zeros(F,2);
P_KNNec=zeros(F,2);
P_KNNmah=zeros(F,2);
P_GM=zeros(F,2);
P_GB=zeros(F,2);
P_GS=zeros(F,2);
P_RF=zeros(F,2);
P_NN_2L=zeros(F,2);
P_com=zeros(F,2);
Err_svmg=zeros(n);
Err_svml=zeros(n);
Err_KNNec=zeros(n);
Err_KNNmah=zeros(n);
Err_GM=zeros(n);
Err_GB=zeros(n);
Err_GS=zeros(n);
Err_RF=zeros(n);
Err_NN=zeros(n);
Err_NN2=zeros(n);
Err_NN_2L=zeros(n);
Err_RF2=zeros(n);
Err_Com=zeros(n);

Step=(length(data)-1)/n;

X=v*u;
for R=2:F
    data=X(:,1:R);
    net=patternnet([1]);
    net2 = feedforwardnet([5]);
    net3 = patternnet([10]);
for i=1:n
    Lower=(1+(i-1)*Step);
    upper=i*Step;
    mdn=fitcsvm(data(Lower:upper,:),training(Lower:upper,21),'KernelFunction','gaussian');
    mdn2=fitcsvm(data(Lower:upper,:),training(Lower:upper,21),'KernelFunction','linear');
    RF=TreeBagger(30,data(Lower:upper,:),training(Lower:upper,21));
    RF2=TreeBagger(30,data(Lower:upper,:),training(Lower:upper,21));
    [net, tr]=train(net,data(Lower:upper,:)',training(Lower:upper,21)');
    [net2, tb]=train(net2,data(Lower:upper,:)',training(Lower:upper,21)');
    [net3, tc]=train(net3,data(Lower:upper,:)',training(Lower:upper,21)');
    for j=1:n
        if j~=i
        lj=1+(j-1)*Step;
        uj=j*Step;
        Y_knn_ec=1:Step;
        Y_knn_mah=1:Step;
        Y_com=1:Step;
        for z=lj:uj
        Y_knn_ec(z-lj+1)=kNNClassifier(data(z,:),data(Lower:upper,:),training(Lower:upper,21),15);
        Y_knn_mah(z-lj+1)=KNN_mah(data(z,:),data(Lower:upper,:),training(Lower:upper,21),15);
        end
        Y_Gaus_md=G_predict(data(Lower:upper,:),data(lj:uj,:),training(Lower:upper,21),'M_dist');
        Y_Gaus_soft=G_predict(data(Lower:upper,:),data(lj:uj,:),training(Lower:upper,21),'soft');
        Y_Gaus_B=G_predict(data(Lower:upper,:),data(lj:uj,:),training(Lower:upper,21),'B_input');
        Y_SVMG=predict(mdn,data(lj:uj,:));
        Y_SVML=predict(mdn2,data(lj:uj,:));
        Y_RF=str2num(cell2mat(predict(RF,data(lj:uj,:))));
        Y_RF2=str2num(cell2mat(predict(RF2,data(lj:uj,:))));
        Y_NN=net(data(lj:uj,:)');
        Y_NN2=net2(data(lj:uj,:)');
        Y_NN_2L=net3(data(lj:uj,:)');
        for M=1:length(Y_NN)
            if Y_NN(M)>0.5
                Y_NN(M)=1;
            else
                Y_NN(M)=0;
            end
        end
        for M=1:length(Y_NN2)
            if Y_NN2(M)>0.5
                Y_NN2(M)=1;
            else
                Y_NN2(M)=0;
            end
        end
        for M=1:length(Y_NN_2L)
            if Y_NN_2L(M)>0.5
                Y_NN_2L(M)=1;
            else
                Y_NN_2L(M)=0;
            end
        end
        for x=1:Step
            Y_com(x)=Y_NN(x)+Y_NN2(x)+Y_RF(x)+Y_RF2(x)+Y_SVML(x)+Y_SVMG(x);
            if Y_com(x)>=3
                Y_com(x)=1;
            else
                Y_com(x)=0;
            end
        end
        Err_svmg(i,j)=ErrorRate(Y_SVMG,training(lj:uj,21));
        Err_svml(i,j)=ErrorRate(Y_SVML,training(lj:uj,21));
        Err_KNNec(i,j)=ErrorRate(Y_knn_ec,training(lj:uj,21));
        Err_KNNmah(i,j)=ErrorRate(Y_knn_mah,training(lj:uj,21));
        Err_GM(i,j)=ErrorRate(Y_Gaus_md,training(lj:uj,21));
        Err_GB(i,j)=ErrorRate(Y_Gaus_soft,training(lj:uj,21));
        Err_GS(i,j)=ErrorRate(Y_Gaus_B,training(lj:uj,21));
        Err_RF(i,j)=ErrorRate(Y_RF,training(lj:uj,21));
        Err_NN(i,j)=ErrorRate(Y_NN,training(lj:uj,21));
        Err_NN2(i,j)=ErrorRate(Y_NN2,training(lj:uj,21));
        Err_NN_2L(i,j)=ErrorRate(Y_NN_2L,training(lj:uj,21));
        Err_RF2(i,j)=ErrorRate(Y_RF2,training(lj:uj,21));
        Err_Com(i,j)=ErrorRate(Y_com,training(lj:uj,21));
        end
        
        end
end
[P_com(R,1),P_com(R,2)]=MeanSTD(Err_Com);
[P_NN(R,1), P_NN(R,2)]=MeanSTD(Err_NN);
[P_NN2(R,1), P_NN2(R,2)]=MeanSTD(Err_NN2);
[P_NN_2L(R,1), P_NN_2L(R,2)]=MeanSTD(Err_NN_2L);
[P_svmg(R,1),P_svmg(R,2)]=MeanSTD(Err_svmg);
[P_svml(R,1),P_svml(R,2)]=MeanSTD(Err_svml);
[P_KNNec(R,1),P_KNNec(R,2)]=MeanSTD(Err_KNNec);
[P_KNNmah(R,1),P_KNNmah(R,2)]=MeanSTD(Err_KNNmah);
[P_GM(R,1),P_GM(R,2)]=MeanSTD(Err_GM);
[P_GB(R,1),P_GB(R,2)]=MeanSTD(Err_GM);
[P_GS(R,1),P_GS(R,2)]=MeanSTD(Err_GS);
[P_RF(R,1),P_RF(R,2)]=MeanSTD(Err_RF);
[P_RF2(R,1),P_RF2(R,2)]=MeanSTD(Err_RF2);
end
X=2:F;
hold all;
errorbar(X,P_com(2:end,1),P_com(2:end,2));
errorbar(X,P_NN(2:end,1),P_NN(2:end,2));
errorbar(X,P_NN2(2:end,1),P_NN2(2:end,2));
errorbar(X,P_NN_2L(2:end,1),P_NN_2L(2:end,2));
errorbar(X,P_svmg(2:end,1),P_svmg(2:end,2));
errorbar(X,P_svml(2:end,1),P_svml(2:end,2));
errorbar(X,P_KNNec(2:end,1),P_KNNec(2:end,2));
errorbar(X,P_KNNmah(2:end,1),P_KNNmah(2:end,2));
errorbar(X,P_GM(2:end,1),P_GM(2:end,2));
errorbar(X,P_GB(2:end,1),P_GB(2:end,2));
errorbar(X,P_GS(2:end,1),P_GS(2:end,2));
errorbar(X,P_RF(2:end,1),P_RF(2:end,2));
errorbar(X,P_RF2(2:end,1),P_RF2(2:end,2));


