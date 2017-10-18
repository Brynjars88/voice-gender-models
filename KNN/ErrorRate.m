function [Err]=ErrorRate(Y1,Y2)

Err=0;
for i=1:length(Y1)
   
    if Y1(i)~=Y2(i)
        Err=Err+1;
   end
    
end
Err=Err/length(Y1);
