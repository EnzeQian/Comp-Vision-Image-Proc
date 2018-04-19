function [ cx,cy,rad ] = GetCircles( scale_space,initial_scale, k, level, threshold )
%GETCIRCLES Summary of this function goes here
% Get Center coordinates and radii for circles
% input:  scale_space: Scale space obtained from LOG filter
%         threshold: threshold that we set
%         initial_scale: Typically set to 2
%         k: Filter incresing factor
%         level: Number of levels in the scale pyramid. Use 10 to 15
% ouptut: 
%         cx, cy: column vectors with x and y coordinates of circle centers
%         rad: column vector with radii of circles. 
mx=[];
for i=1:level
mx(:,:,i) = ordfilt2(scale_space(:,:,i),9,ones(3)); % find max in each 2D layer
end

%Perfrom nonmaximum suppression in scale place
%need to compared with its neighborhood and threshold

%mx(:,:,1)=(scale_space(:,:,1)==mx(:,:,1))&(mx(:,:,1)>mx(:,:,2))&(mx(:,:,1)>threshold); 
%mx(:,:,level)=(scale_space(:,:,level)==mx(:,:,level))&(mx(:,:,level)>mx(:,:,level-1))&(mx(:,:,level)>threshold);
%for i=2:(level-1)
%mx(:,:,i)=(scale_space(:,:,i)==mx(:,:,i))&(mx(:,:,i)>mx(:,:,i+1))&(mx(:,:,i)>mx(:,:,i-1))&(mx(:,:,1)>threshold);
%end
mx(:,:,1)=max(mx(:,:,1:2),[],3);%first layer only compared with second layer
mx(:,:,level)=max(mx(:,:,level-1:level),[],3);%LEVELth layer only compared with(LEVEL-1)th 
for i=2:(level-1)
mx(:,:,i)=max(mx(:,:,i-1:i+1),[],3);
end
%(cim==mx)&(cim>thresh) inspired by the code from harris.m 

mx = mx & (mx == scale_space) & (mx>threshold);
%find cx cy and rad
cx=[];
cy=[];
rad=[];
for i=1:level
%i
sigma=initial_scale*k^(i-1);
[r,c]=find(mx(:,:,i));
temp=length(r);
cx=[cx;c];
cy=[cy;r];
%lengthr=length(r)
rid=[];
rid(1:temp)=sigma*sqrt(2); %max response is achived with sigma=r/sqrt(2)
%length(transpose(rid))
rad=[rad;transpose(rid)];
end
end

