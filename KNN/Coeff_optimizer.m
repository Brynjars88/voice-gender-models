function [ Opt,Opt_test ] = Coeff_optimizer( Matrix,Test, level )
%Function that removes colums that have a high correlation with another
%column in the data matrix variables M is the matrix being optimized and
%level is what correlation is required for a column to be removed
%   A is the Linear correlation coefficient Matrix for the Data Matrix, 
% We iterate through A and find any colum A(i,j) and remove any colum where
% the absolute of the correlation coefficient is higher or equal to the  level variable 

A=corrcoef(Matrix);
[N, M] =size(A);
Z=[];
for i=1:N
    j=i+1;
        for j=i+1:M
            if abs(A(i,j))>=level
              Z=[Z j];
            end            
        end
    if length(Z)>0

        Matrix(:,Z)=[];
        Test(:,Z)=[];
        A=corrcoef(Matrix);
        [N, M] =size(A);
        
    end

    
    Z=[];
end
Opt=Matrix;
Opt_test=Test;