function [ new_matches ] = RANSAC_part2( matches )
%RANSAC_PART2 Summary of this function goes here
%   Detailed explanation goes here
threshold=20;
interations=1000;
best=0;
distancetemp=0;
for i=1:interations
    index=randperm(size(matches,1),4);
    matches_temp=matches(index,:);
    
    F_temp = fit_fundamental(matches_temp);
    N = size(matches,1);
    L = (F_temp * [matches(:,1:2) ones(N,1)]')'; 
    L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3); 
    pt_line_dist = sum(L .* [matches(:,3:4) ones(N,1)],2);
    closest_pt = matches(:,3:4) - L(:,1:2) .* repmat(pt_line_dist, 1, 2);
    distance=sqrt((closest_pt(:,1)-matches(:,3)).^2+(closest_pt(:,2)-matches(:,4)).^2);
    mask=distance<threshold;
    if sum(mask)>best
        best=sum(mask);
        F=F_temp;
        location=find(mask);
        new_matches=matches(location,:);
        distancetemp=distance;
    end
end
  best
  sum(distancetemp)/best;
end

