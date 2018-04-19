a=load('../data/art_gallery/sun_aaaxsldstlpzwrbe.mat');
b=getImageFeaturesSPM(3, a.wordMap, 100);
histogram(b)