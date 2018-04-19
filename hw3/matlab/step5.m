function [matchx1,matchy1,matchx2,matchy2] = step5( x1,y1,x2,y2,distance )
%STEP5 Summary of this function goes here
%   Detailed explanation goes here    
N=300;
indx=zeros(N,1);
temp=distance(:);
for i=1:N %for large matrix distance, sort may very slow, hence use for loop
    [~,indx(i)]=min(temp);
    temp(indx(i))=inf;
end
[idx1,idx2]=ind2sub(size(distance),indx);
matchx1=x1(idx1);
matchy1=y1(idx1);
matchx2=x2(idx2);
matchy2=y2(idx2);
end

