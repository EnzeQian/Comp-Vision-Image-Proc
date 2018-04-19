function [ convert ] = step1(img)
%STEP1 Summary of this function goes here
%   Detailed explanation goes here
convert=rgb2gray(img);
convert=im2double(convert);
end

