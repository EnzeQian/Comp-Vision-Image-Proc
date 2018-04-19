function [ x,y ] = step2( img )
%STEP2 Summary of this function goes here
%   Detailed explanation goes here
sigma=3;
thresh=0.01;
radius=3;
disp=0;
[cim, r, c]=harris(img, sigma, thresh, radius, disp);
x=c;
y=r;
end
