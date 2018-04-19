function [ h ] = getImageFeaturesDividedBy4( wordMap, dictionarySize )
%GETIMAGEFEATURESDIVIDEDBY4 Summary of this function goes here
%   Detailed explanation goes here
a = wordMap(1:end/2, 1:end/2);
b = wordMap(1:end/2, end/2+1:end);
c = wordMap(end/2+1:end, 1:end/2);
d = wordMap(end/2+1:end, end/2+1:end);
ha=getImageFeatures(a, dictionarySize);
hb=getImageFeatures(b, dictionarySize);
hc=getImageFeatures(c, dictionarySize);
hd=getImageFeatures(d, dictionarySize);
h=ha+hb+hc+hd;
h=h./sum(h);
end

