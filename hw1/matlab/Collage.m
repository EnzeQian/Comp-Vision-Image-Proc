input=imread('../data/ice_skating/sun_advbapyfkehgemjf.jpg');
fb=createFilterBank();
fr=extractFilterResponses(input,fb);
output=montage(reshape(fr,[size(input,1),size(input,2),3,20]),'size',[4 5]);
imshow(output);