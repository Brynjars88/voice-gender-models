load voice.txt

P = randperm(size(voice,1));

trainSize = floor(0.9*length(P));
testSize = ceil(0.1*length(P));

training = zeros(trainSize,size(voice,2));
for i = 1:trainSize
    training(i,:) = voice(P(i),:);
end

test = zeros(testSize,size(voice,2));
for i = 1:testSize
    test(i,:) = voice(P(i),:);
end