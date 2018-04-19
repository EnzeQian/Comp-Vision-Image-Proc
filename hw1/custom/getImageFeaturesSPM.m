function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here
%layer0 h:
h0=getImageFeatures(wordMap, dictionarySize);
%layer1 h:
h1=getImageFeaturesDividedBy4(wordMap, dictionarySize);
%layer2 h:
a = wordMap(1:end/2, 1:end/2);
b = wordMap(1:end/2, end/2+1:end);
c = wordMap(end/2+1:end, 1:end/2);
d = wordMap(end/2+1:end, end/2+1:end);
ha=getImageFeaturesDividedBy4(a, dictionarySize);
hb=getImageFeaturesDividedBy4(b, dictionarySize);
hc=getImageFeaturesDividedBy4(c, dictionarySize);
hd=getImageFeaturesDividedBy4(d, dictionarySize);
h2=ha+hb+hc+hd;
h2=h2./sum(h2);
%add weight
h=0.25*h0+0.25*h1+0.5*h2;
h=h./sum(h);
end