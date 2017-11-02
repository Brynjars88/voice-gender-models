function [ mean_m,s ] = MeanSTD( M )

M=M(M~=0);

mean_m=mean(M);
s=std(M);


end

