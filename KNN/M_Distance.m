function [ Y ] = M_Distance( Mu1,Mu2,Target )
%Minimum_DISTANCE classifier assuming two normal distributed classes
%

D0=norm(Target-Mu1,2);
D1=norm(Target-Mu2,2);
if D0<D1
    Y=0;
else
    Y=1;
end

