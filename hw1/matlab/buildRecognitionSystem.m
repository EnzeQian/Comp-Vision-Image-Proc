function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../data/traintest.mat');
	% TODO create train_features
    train_features=[];
    for i=1:length(train_imagenames)
    convert=strrep(train_imagenames(i),'.jpg','.mat');
    image=load(char(strcat('../data/',convert)));
    features=getImageFeaturesSPM(3,image.wordMap,100); %Dictionary size is 100 in my choice.
    train_features=[train_features features];
    end
    filterBank=createFilterBank();
	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end