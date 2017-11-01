clear all
load voice.txt



Err=[];

std_1=[];
Err_normed=[];
std_n=[];
F=length(voice);
%K=round(sqrt(length(training)),0);
for i=1:10
e=[];
e_N=[];
K=5*i;
for j=1:10
voice=voice(randperm(F),:);
training=voice(1:2851,:);
test=voice(2852:end,:);
test_N=Norm_Matrix(test);
training_N=Norm_Matrix(training);
target=test(:,21);

for k=1:length(test)
    Y(k)=kNNClassifier(test(k,1:20),training(:,1:20),training(:,21),K);
    Y_N(k)=kNNClassifier(test_N(k,1:20),training_N(:,1:20),training(:,21),K);
    

end
e=[e ErrorRate(Y,target)];
e_N=[e_N ErrorRate(Y_N,target)];
end
Err=[Err mean(e) ];
Err_normed=[Err_normed mean(e_N)];
std_1=[std_1 std(e)];
std_n=[std_n std(e_N)];


end
hold all
x=linspace(1,10,10)*5;
errorbar(x,Err,std_1)
errorbar(x,Err_normed,std_n)

%%
%Testing Mah distance classification
K=35;
for i=1:length(test)
    Ym(i)=KNN_mah(test(i,1:20),training(:,1:20),training(:,21),K);
    Ym_n(i)=KNN_mah(test_N(i,1:20),training_N(:,1:20),training(:,21),K);
end
%Testing Cosine classification accuracy
Err_mah=ErrorRate(Ym,target);
Err_mah_normed=ErrorRate(Ym_n,target);

for i=1:length(test)
    Yc(i)=KNN_cosine(test(i,1:20),training(:,1:20),training(:,21),K);
    Yc_n(i)=KNN_cosine(test_N(i,1:20),training_N(:,1:20),training(:,21),K);
end
Err_Co=ErrorRate(Yc,target);
Err_Co_normed=ErrorRate(Yc_n,target);





