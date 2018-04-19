function [ stitching ] = step78( H,img1,img2 )
%STEP78 Summary of this function goes here
%   Detailed explanation goes here
    img1=im2double(img1);
    img2=im2double(img2);
    T=maketform('projective', H');
    [row2, column2 ,~]=size(img2);
    [~,xdata,ydata]=imtransform(img1,T); 
    %xdata specifies x-cooudinates of the first and last columns of left img
    %ydata specifies y-cooudinates of the first and last rows of left img
    newxdata(1)=min(xdata(1),1);
    newxdata(2)=max(xdata(2),column2);
    newydata(1)=min(ydata(1),1);
    newydata(2)=max(ydata(2),row2);
    left=imtransform(img1,T,'XData',newxdata,'YData',newydata);
    T2=maketform('projective',eye(3));
    right=imtransform(img2,T2,'XData',newxdata,'YData',newydata);
    mask=(left~=0 & right~=0);
    left(mask)=left(mask)/2;
    right(mask)=right(mask)/2;
    stitching=left+right;
    imshow(stitching);
end

