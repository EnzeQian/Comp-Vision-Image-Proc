function [T, num_inliers, avg_residual,points1,points2] = step6(x1, y1, x2, y2)
%STEP6 Summary of this function goes here
%   Detailed explanation goes here
    set1 = [x1, y1]; 
    set2 = [x2, y2];
    N=size(x1,1);
    M=4; 
    n=30000;    % iteration times
    threshold = 5;    % threshold between inliers and outliers
    num_inliers = 0;
    avg_residual = 0;
    distancetemp=0;
    T=zeros(3,3);
    for i = 1:n
        sdindx = randperm(N,M);
        A=set1(sdindx,:);
        B=set2(sdindx,:);
        H = H_fitting(A,B);
        distance=getDistance(H,x1,y1,x2,y2);
        index_inliers=find(distance<threshold);
        num_temp=length(index_inliers);
        distancetotal=sum((distance<threshold).*distance);
        if(num_temp>num_inliers)
            num_inliers=num_temp;
            a=set1(index_inliers,:);
            b=set2(index_inliers,:);
            T=H_fitting(a,b);
            distancetemp=distancetotal;
        end
    end  
    avg_residual=distancetemp/num_inliers;
    points1=a;
    points2=b;
end
function H = H_fitting(points1,points2)
    n = size(points1,1);
    x1=points1(:,1); y1=points1(:,2);
    x2=points2(:,1); y2=points2(:,2);
    points1 = [points1, ones(n,1)];
    points2 = [points2, ones(n,1)];
    A = zeros(2*n,9);
    i = 1:n;
    A(2*i-1,1:3) = points1;
    A(2*i,1:3) = 0;
    A(2*i-1,4:6) = 0;
    A(2*i,4:6) = points1;
    for i=1:n
    A(2*i-1,7)=-x1(i).*x2(i);
    A(2*i,7)=-x1(i).*y2(i);
    A(2*i-1,8)=-y1(i).*x2(i);
    A(2*i,8)=-y1(i).*y2(i);
    A(2*i-1,9)=-x2(i);
    A(2*i,9)=-y2(i);
    end
    [~,~,V] = svd(A); x=V(:,end);
    H = reshape(x,[3,3]);
    H=H./H(3,3);
    H=H';
end

function [distance]=getDistance(H,x1,y1,x2,y2)
set1=[x1,y1,ones(size(x1,1),1)];
transSet1=(H*set1')';
t1=transSet1(:,3);
xdist=x2-transSet1(:,1)./t1;
ydist=y2-transSet1(:,2)./t1;
distance = xdist.^2+ydist.^2;
end

