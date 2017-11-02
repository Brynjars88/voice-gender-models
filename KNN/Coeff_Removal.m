function [ Matr ] = Coeff_Removal( Data , K)
%Removes the matri
%   Detailed explanation goes here
A=corrcoef(Data);
[N, M] =size(A);
Matr=Data;
level=1;
while level ~=0
for i=1:N
        for j=i+1:M
            if abs(A(i,j))>=level
            Matr(:,j)=[];    
            A=corrcoef(Matr);
            [N, M] =size(A);
            
                if M == K
                    return
                end
            break
            end            
        end
end
level=level-0.01;
    
end


