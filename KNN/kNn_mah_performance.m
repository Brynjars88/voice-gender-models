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
    

    
    
K=35;



Target=test(:,21);

test_N=Norm_Matrix(test);
training_N=Norm_Matrix(training);
[opt60, opt_test60]=Coeff_optimizer(training(:,1:20),test(:,1:20) ,0.60);
[opt70, opt_test70]=Coeff_optimizer(training(:,1:20),test(:,1:20) ,0.70);
[opt80, opt_test80]=Coeff_optimizer(training(:,1:20),test(:,1:20) ,0.80);
[opt90, opt_test90]=Coeff_optimizer(training(:,1:20),test(:,1:20) ,0.90);

test_N_opt60=Norm_Matrix(opt_test60);
train_N_opt60=Norm_Matrix(opt60);
test_N_70=Norm_Matrix(opt_test70);
train_N_70=Norm_Matrix(opt70);

test_N_80=Norm_Matrix(opt_test80);
train_N_80=Norm_Matrix(opt80);


test_N_90=Norm_Matrix(opt_test90);
train_N_90=Norm_Matrix(opt90);

for i=1:length(test)
    Y(i)=KNN_mah(test(i,1:20),training(:,1:20),training(:,21),K);
    Y_N(i)=KNN_mah(test_N(i,1:20),training_N(:,1:20),training(:,21),K);
    
    Y_60(i)=KNN_mah(opt_test60(i,:),opt60,training(:,21),K);
    Y_60_N(i)=KNN_mah(test_N_opt60(i,:),train_N_opt60,training(:,21),K);
    
    Y_70(i)=KNN_mah(opt_test70(i,:),opt70,training(:,21),K);
    Y_70_N(i)=KNN_mah(test_N_70(i,:),train_N_70,training(:,21),K);
    
    
    Y_80(i)=KNN_mah(opt_test80(i,:),opt80,training(:,21),K);
    Y_80_N(i)=KNN_mah(test_N_80(i,:),train_N_80,training(:,21),K);
    
    
    Y_90(i)=KNN_mah(opt_test90(i,:),opt90,training(:,21),K);
    Y_90_N(i)=KNN_mah(test_N_90(i,:),train_N_90,training(:,21),K);
end
Err=[ Err ErrorRate(Y,Target)];
Err_normed=[ Err_normed ErrorRate(Y_N,Target)];
Err_60=[ Err_60 ErrorRate(Y_60,Target)];
Err_N60=[ Err_N60 ErrorRate(Y_60_N,Target)];
Err_70=[ Err_70 ErrorRate(Y_70,Target)];
Err_N70=[ Err_N70 ErrorRate(Y_70_N,Target)];
Err_80=[Err_80 ErrorRate(Y_80,Target)];
Err_N80=[Err_N80 ErrorRate(Y_80_N,Target)];
Err_90=[Err_90 ErrorRate(Y_90,Target)];
Err_N90=[Err_N90 ErrorRate(Y_90_N,Target)];
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