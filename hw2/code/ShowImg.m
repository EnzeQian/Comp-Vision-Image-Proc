I='../data/computer.jpg';
initial_scale=2;
k=1.19;
level=15;
threshold=0.001;
scale_space=[];
%scale_space=SlowGetScaleSpace(I,initial_scale,k,level);
scale_space=FastGetScaleSpace(I,initial_scale,k,level);
[cx,cy,r]=GetCircles(scale_space,initial_scale,k,level,threshold);
show_all_circles(I,cx,cy,r);