load '../data/voiceTrain.mat'

maleTraining = [];
femaleTraining = [];

for i = 1:size(training,1)
    if training(i,21) == 1
        maleTraining = [maleTraining; training(i,:)];
    else
        femaleTraining = [femaleTraining; training(i,:)];
    end
end