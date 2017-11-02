load voiceTrain
load voicetest

Tr_N=Norm_Matrix(training(:,1:20));
T_N=Norm_Matrix(test(:,1:20));

mdl=fitcsvm(training(:,1:20),training(:,21),'KernelFunction','gaussian');
Mdl1=fitcsvm(training(:,1:20),training(:,21),'KernelFunction','linear');
mdn=fitcsvm(Tr_N,training(:,21),'KernelFunction','gaussian');
Mdn1=fitcsvm(Tr_N,training(:,21),'KernelFunction','linear');

Y=predict(mdl,test(:,1:20));
Y2=predict(Mdl1,test(:,1:20));
Y3=predict(mdn,T_N);
Y4=predict(Mdn1,T_N);

err=ErrorRate(Y,test(:,21));
err2=ErrorRate(Y2,test(:,21));
err3=ErrorRate(Y3,test(:,21));
err4=ErrorRate(Y4,test(:,21));

