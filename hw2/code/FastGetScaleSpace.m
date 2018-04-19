function [ scale_space ] = FastGetScaleSpace( I, initial_scale, k, level )
%FASTGETSCALESPACE Summary of this function goes here
% Getting scale_space,filter unchanged and downsample image 
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
filter=fspecial('log',floor(2*(3*initial_scale))+1,initial_scale);
factor=1/k;
for i=1:level
downsample=imresize(I,factor);
filtered=imfilter(downsample,filter);
filtered=filtered .* filtered;
upsample=imresize(filtered,size(I),'bicubic'); %interpolation method 'nearest' 'bilinear' 'bicubic'
scale_space(:,:,i)=upsample;
factor=factor*(1/k);
end
toc
end

