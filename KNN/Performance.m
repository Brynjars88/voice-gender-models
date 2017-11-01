load voiceTrain
n=10;
data=Norm_Matrix(training(:,1:20));
[u,v]=pca(data);
Err_svmg=zeros(n);
Err_svml=zeros(n);
Err_KNNec=zeros(n);
Err_KNNmah=zeros(n);
Err_GM=zeros(n);
Err_GB=zeros(n);
Err_GS=zeros(n);
Err_RF=zeros(n);
Err_NN=zeros(n);
Step=(length(data)-1)/n;
net=patternnet(10);
for i=1:n
    Lower=(1+(i-1)*Step);
    upper=i*Step;
    mdn=fitcsvm(data(Lower:upper,:),training(Lower:upper,21),'KernelFunction','gaussian');
    mdn2=fitcsvm(data(Lower:upper,:),training(Lower:upper,21),'KernelFunction','linear');
    RF=TreeBagger(30,data(Lower:upper,:),training(Lower:upper,21));
    [net, tr]=train(net,data(Lower:upper,:)',training(Lower:upper,21)');
    for j=1:n
        if j~=i
        lj=1+(j-1)*Step;
        uj=j*Step;
        Y_knn_ec=1:Step;
        Y_knn_mah=1:Step;
        for z=lj:uj
        Y_knn_ec(z-lj+1)=kNNClassifier(data(z,:),data(Lower:upper,:),training(Lower:upper,21),15);
        Y_knn_mah(z-lj+1)=KNN_mah(data(z,:),data(Lower:upper,:),training(Lower:upper,21),15);
        end
        Y_Gaus_md=G_predict(data(Lower:upper,:),data(lj:uj,:),training(Lower:upper,21),'M_dist');
        Y_Gaus_soft=G_predict(data(Lower:upper,:),data(lj:uj,:),training(Lower:upper,21),'soft');
        Y_Gaus_B=G_predict(data(Lower:upper,:),data(lj:uj,:),training(Lower:upper,21),'B_input');
        Y=predict(mdn,data(lj:uj,:));
        Y1=predict(mdn2,data(lj:uj,:));
        Y_RF=str2num(cell2mat(predict(RF,data(lj:uj,:))));
        Y_NN=net(data(lj:uj,:)');
        for M=1:length(Y_NN)
            if Y_NN(M)>0.5
                Y_NN(M)=1;
            else
                Y_NN(M)=0;
            end
        end
        Err_svmg(i,j)=ErrorRate(Y,training(lj:uj,21));
        Err_svml(i,j)=ErrorRate(Y1,training(lj:uj,21));
        Err_KNNec(i,j)=ErrorRate(Y_knn_ec,training(lj:uj,21));
        Err_KNNmah(i,j)=ErrorRate(Y_knn_mah,training(lj:uj,21));
        Err_GM(i,j)=ErrorRate(Y_Gaus_md,training(lj:uj,21));
        Err_GB(i,j)=ErrorRate(Y_Gaus_soft,training(lj:uj,21));
        Err_GS(i,j)=ErrorRate(Y_Gaus_B,training(lj:uj,21));
        Err_RF(i,j)=ErrorRate(Y_RF,training(lj:uj,21));
        Err_NN(i,j)=ErrorRate(Y_NN,training(lj:uj,21));
        end
    end
end

