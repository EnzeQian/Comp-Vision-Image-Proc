function [ scale_space ] = SlowGetScaleSpace( I, initial_scale, k, level )
%SLOWGETSCALESPACE Summary of this function goes here
% Getting scale_space,Image unchanged and Incresing filter size 
%  input:     I: Image location
%            initial_scale: Typically set to 2
%            k: Filter incresing factor
%            level: Number of levels in the scale pyramid. Use 10 to 15 

%  output:    scale_space: A 3-D array to represent scale space.
tic
I=imread(I);
I=rgb2gray(I);
I=im2double(I);
h=size(I,1);
w=size(I,2);
scale_space=zeros(h,w,level);
for i=1:level
sigma=initial_scale*k^(i-1);
filter=fspecial('log',floor(2*(3*sigma))+1,sigma)*sigma^2; %muti sigma square for scal normalization
scale_space(:,:,i)=imfilter(I,filter).^2; %save square of LOG response for current space.
end
toc
end

