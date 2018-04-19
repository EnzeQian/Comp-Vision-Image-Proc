p1=load('../data/part2/library1_camera.txt');
p2=load('../data/part2/library2_camera.txt');
matches = load('../data/part2/library_matches.txt'); 
center1=get_center(p1);
center2=get_center(p2);
%knowing x1 x2 P1 P2 solve X
x1=[matches(:,1) matches(:,2) ones(size(matches(:,1)))];
x2=[matches(:,3) matches(:,4) ones(size(matches(:,1)))];
for i=1:size(x1)
x1P1=cross_product(x1(i,:),p1);
x2P2=cross_product(x2(i,:),p2);
M=[x1P1;x2P2];
%solving X by svd
[~,~,V]=svd(M);
X=V(:,end);
homo=X./X(4);
triangulated_points(1:3,i)=homo(1:3);
projected_points1(1:3,i)=p1*homo;
projected_points1(1:3,i)=projected_points1(1:3,i)./projected_points1(3,i);
projected_points2(1:3,i)=p2*homo;
projected_points2(1:3,i)=projected_points2(1:3,i)./projected_points2(3,i);
end

%calculate residual
disntance1=calc_residuals(x1,projected_points1)
disntance2=calc_residuals(x2,projected_points2)

figure;
plot3(triangulated_points(1,:),triangulated_points(2,:),triangulated_points(3,:),'.r'), axis equal, hold on;
plot3(center1(1),center1(2),center1(3),'ok'), axis equal, hold on;
plot3(center2(1),center2(2),center2(3),'or'), axis equal, hold on;


function [center] = get_center(camera)
[~,~,V]=svd(camera);
center=V(:,end);
center=center/center(4);
end

function [result]=cross_product(a,b)
ax=[0 -a(3) a(2); a(3) 0 -a(1); -a(2) a(1) 0];
result=ax*b;
end

function [distance]=calc_residuals(twoD,threeD)
x=twoD(:,1);
y=twoD(:,2);
x3d=threeD(1,:)';
y3d=threeD(2,:)';
distance=sqrt((x-x3d).^2+(y-y3d).^2);
distance=sum(distance);
end