function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    % TODO Implement your code here
fr=extractFilterResponses(img,filterBank);
fr=reshape(fr,[],60);
[D,I]=pdist2(transpose(dictionary),fr,'euclidean','Smallest',1);
wordMap=reshape(I,size(img,1),size(img,2));
end
