I1 = imread('../data/part2/library1.jpg');
I2 = imread('../data/part2/library2.jpg');
step=2;
if(step==2)
matches = load('../data/part2/library_matches.txt'); 
elseif(step==3)
img1=step1(I1);
img2=step1(I2);
[x1,y1]=step2(img1); 
[x2,y2]=step2(img2);
descriptors1=step3(img1,x1,y1);
descriptors2=step3(img2,x2,y2); 
distance=step4(descriptors1,descriptors2);
[x1match,y1match,x2match,y2match]=step5(x1,y1,x2,y2,distance);
matches=[x1match y1match x2match y2match];
end    


% first, fit fundamental matrix to the matches
if(step==2)
F = fit_fundamental(matches); % this is a function that you should write
elseif(step==3)
matches=RANSAC_part2(matches);
F=fit_fundamental(matches);
end
N = size(matches,1);

L = (F * [matches(:,1:2) ones(N,1)]')'; % transform points from 
% the first image to get epipolar lines in the second image

% find points on epipolar lines L closest to matches(:,3:4)
L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3); % rescale the line
pt_line_dist = sum(L .* [matches(:,3:4) ones(N,1)],2);
closest_pt = matches(:,3:4) - L(:,1:2) .* repmat(pt_line_dist, 1, 2);

distance=sqrt((closest_pt(:,1)-matches(:,3)).^2+(closest_pt(:,2)-matches(:,4)).^2);
distance=mean(distance)

% find endpoints of segment on epipolar line (for display purposes)
pt1 = closest_pt - [L(:,2) -L(:,1)] * 10; % offset from the closest point is 10 pixels
pt2 = closest_pt + [L(:,2) -L(:,1)] * 10;

% display points and segments of corresponding epipolar lines
clf;
imshow(I2); hold on;
plot(matches(:,3), matches(:,4), '+r');
line([matches(:,3) closest_pt(:,1)]', [matches(:,4) closest_pt(:,2)]', 'Color', 'r');
line([pt1(:,1) pt2(:,1)]', [pt1(:,2) pt2(:,2)]', 'Color', 'g');