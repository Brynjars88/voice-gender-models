%in this program we test several diffrent version of Classifiers that 

load voice.txt

Err=[];                
Err_normed=[];
Err_60=[];
Err_N60=[];
Err_70=[];
Err_N70=[];
Err_80=[];
Err_N80=[];
Err_90=[];
Err_N90=[];
F=length(voice);

for i=1:30

voice=voice(randperm(F),:);
training=voice(1:2851,:);
test=voice(2852:end,:);


Trclass=training(:,21);
Target=test(:,21);

test_N=Norm_Matrix(test(:,1:20));
training_N=Norm_Matrix(training(:,1:20));
[opt60, opt_test60]=Coeff_optimizer(training(:,1:20),test(:,1:20) ,0.60);
[opt70, opt_test70]=Coeff_optimizer(training(:,1:20),test(:,1:20) ,0.70);
[opt80, opt_test80]=Coeff_optimizer(training(:,1:20),test(:,1:20) ,0.80);
[opt90, opt_test90]=Coeff_optimizer(training(:,1:20),test(:,1:20) ,0.90);

test_N60=Norm_Matrix(opt_test60);
train_N60=Norm_Matrix(opt60);
test_N70=Norm_Matrix(opt_test70);
train_N70=Norm_Matrix(opt70);
test_N80=Norm_Matrix(opt_test80);
train_N80=Norm_Matrix(opt80);
test_N90=Norm_Matrix(opt_test90);
train_N90=Norm_Matrix(opt90);

A2='soft';
A3='M_dist';
A1='B_input';
Y=G_predict(training(:,1:20),test(:,1:20),Trclass,A3);
Y_N=G_predict(training_N(:,1:20),test_N,Trclass,A3);
Y_60=G_predict(opt60,opt_test60,Trclass,A3);
Y_70=G_predict(opt70,opt_test70,Trclass,A3);
Y_80=G_predict(opt80,opt_test80,Trclass,A3);
Y_90=G_predict(opt90,opt_test90,Trclass,A3);
Y_60N=G_predict(train_N60,test_N60,Trclass,A3);
Y_70N=G_predict(train_N70,test_N70,Trclass,A3);
Y_80N=G_predict(train_N80,test_N80,Trclass,A3);
Y_90N=G_predict(train_N90,test_N90,Trclass,A3);

Err=[ Err ErrorRate(Y,Target)];
Err_normed=[ Err_normed ErrorRate(Y_N,Target)];
Err_60=[ Err_60 ErrorRate(Y_60,Target)];
Err_N60=[ Err_N60 ErrorRate(Y_60N,Target)];
Err_70=[ Err_70 ErrorRate(Y_70,Target)];
Err_N70=[ Err_N70 ErrorRate(Y_70N,Target)];
Err_80=[Err_80 ErrorRate(Y_80,Target)];
Err_N80=[Err_N80 ErrorRate(Y_80N,Target)];
Err_90=[Err_90 ErrorRate(Y_90,Target)];
Err_N90=[Err_N90 ErrorRate(Y_90N,Target)];
end

Error_raw = [mean(Err), std(Err)];
Error_Normed = [mean(Err_normed), std(Err_normed)];
Error_opt_60 =[mean(Err_60), std(Err_60)];
Error_opt_60_normed =[mean(Err_N60), std(Err_N60)];

Error_opt_70 =[mean(Err_70), std(Err_70)];
Error_opt_70_normed =[mean(Err_N70), std(Err_N70)];

Error_opt_80 =[mean(Err_80), std(Err_80)];
Error_opt_80_normed =[mean(Err_N80), std(Err_N80)];

Error_opt_90 =[mean(Err_90), std(Err_90)];
Error_opt_90_normed =[mean(Err_N90), std(Err_N90)];