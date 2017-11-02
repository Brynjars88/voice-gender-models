function [ ErrorA ] = Find_Errors( Main_index, Target )
%find the indexes where our prediction is wrong
%   Detailed explanation goes here
ErrorA=sum((ismember(Main_index,Target)))/length(Main_index);

end

