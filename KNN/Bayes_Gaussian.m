function [ Y ] = Bayes_Gaussian( MeanC1,MeanC2,cvar_C1,cvar_C2,X)
%Bayes classifier employing 
%   the addition of eye is to prevent 
cvar_C1=(cvar_C1+eye(length(cvar_C1))*0.0001)^(-1);
cvar_C2=(cvar_C2+eye(length(cvar_C1))*0.0001)^(-1);
A0=X*-0.5*cvar_C1*X'+(cvar_C1*MeanC1')'*X'+(-0.5)*MeanC1*cvar_C1*MeanC1'-0.5*log(det(cvar_C1));
A1=X*-0.5*cvar_C2*X'+(cvar_C2*MeanC2')'*X'+(-0.5)*MeanC2*cvar_C2*MeanC2'-0.5*log(det(cvar_C2));

if (A1-A0) <0
    Y=0;
else 
    Y=1;

end

