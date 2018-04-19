function [ discriptor ] = step3(img,x,y)
%STEP3 Summary of this function goes here
%   Detailed explanation goes here
enlarge_factor=1.5;
circle=[x,y,3*ones(size(x))];%3 is the radius in harris.m
discriptor=find_sift(img, circle, enlarge_factor);
end

