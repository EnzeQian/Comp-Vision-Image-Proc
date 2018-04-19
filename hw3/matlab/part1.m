img1=imread('../data/part1/uttower/left.jpg');
img2=imread('../data/part1/uttower/right.jpg');
img1=step1(img1);
img2=step1(img2);
[x1,y1]=step2(img1); %check
[x2,y2]=step2(img2);
descriptors1=step3(img1,x1,y1);
descriptors2=step3(img2,x2,y2); %check
distance=step4(descriptors1,descriptors2);
[x1match,y1match,x2match,y2match]=step5(x1,y1,x2,y2,distance); %check
img1=im2double(imread('../data/part1/uttower/left.jpg'));
img2=im2double(imread('../data/part1/uttower/right.jpg'));

%for showing matching points on two images.
%{ 
imshow([img1 img2]);
hold on;
scatter(x1match,y1match,'y','filled');
scatter(x2match+size(img1,2),y2match,'y','filled');
%}
[T,InlierNum,AvgResidual,points1,points2]=step6(x1match,y1match,x2match,y2match);
%for showing inliers matches points on two images.
%{ 
imshow([img1 img2]);
hold on;
scatter(points1(:,1),points1(:,2),'y','filled');
scatter(points2(:,1)+size(img1,2),points2(:,2),'y','filled');
%}
img=step78(T,img1,img2);