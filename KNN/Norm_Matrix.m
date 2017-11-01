function [ norm_M ] = Norm_Matrix( M )
%takes a Nxm Matrix and normalizes every column
[n , m] =size(M);
norm_M=M;
for i=1:n
    for j=1:m
        norm_M(i,j)=(M(i,j)-min(M(:,j)))/(max(M(:,j))-min(M(:,j)));
    end

end

