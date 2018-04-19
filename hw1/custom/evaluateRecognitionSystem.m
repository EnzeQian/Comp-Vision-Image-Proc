function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');
    %for i=1:length(test_)
	% TODO Implement your code here 
   % a=guessImage('../data/mountain/sun_aaaysslbipsngfqb.jpg');
   % find(strcmp(a,mapping))
    conf=zeros(8,8);
    for i=1:length(test_imagenames)
    result=guessImage(char(strcat('../data/',test_imagenames(i))));
    index=find(strcmp(result,mapping));
    conf(index,test_labels(i))=conf(index,test_labels(i))+1;
    end
    accuracy=trace(conf)/sum(conf(:))
end