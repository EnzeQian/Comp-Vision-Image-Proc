I=imread('../data/butterfly.jpg');
I=rgb2gray(I);
I=im2double(I);
tic
ordfilt2(I(:,:,1),9,ones(3));
toc
tic
fun = @(x) max(x(:));
nlfilter(I(:,:,1),[3 3],fun); 
toc
tic
colfilt(I(:,:,1),[3 3],'sliding',@max);
toc