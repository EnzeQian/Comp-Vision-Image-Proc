function [ F ] = fit_fundamental( matches )
%FIT_FUNDAMENTAL Summary of this function goes here
%   Detailed explanation goes here
  normal=1;
  points1=matches(:,1:2);
  points2=matches(:,3:4);
  if(normal==1)
  %get normalizing transformations T1 and T2
  %get normalizing position x1 y1 x2 y2
  %Center the image dataat the origin, and scale it so the mean squared
  %distance between the origin and the data points is 2 pixels.
  [points1, T1] = noramlize(matches(:,1:2));
  [points2, T2] = noramlize(matches(:,3:4));
  
  end
  
  %build matrix for eight-point algorithm
  x1=points1(:,1);
  y1=points1(:,2);
  x2=points2(:,1);
  y2=points2(:,2);
  A=[x1.*x2, x2.*y1, x2, y2.*x1,y2.*y1, y2, x1, y1, ones(size(x1))];

  %AF=0
  [~,~,V]=svd(A);
  X=V(:,end);
  F=reshape(X,3,3)';
  
  %Enfore rank-2 take SVD of F and throw out the smallest singular value
  [U,S,V]=svd(F);
  S(end)=0; %throw out the smallest singular value
  F = U*S*V';
  
  if(normal==1)
    %the fundamental matrix in original coordinates is T2'*F*T1
   F=T2'*F*T1; 
  end
end

function [points, T] = noramlize(points)
x=points(:,1);
y=points(:,2);
meanx=mean(x);
meany=mean(y);
distance=sqrt((x-meanx).^2+(y-meany).^2);
scale=2/mean(distance);
T(1,:)=[scale 0 -scale*meanx];
T(2,:)=[0 scale -scale*meany];
T(3,:)=[0 0 1];
points=[x,y,ones(size(x))];
points=(T*points')';
end
