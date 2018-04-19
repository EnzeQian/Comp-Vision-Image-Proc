function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses


% TODO Implement your code here
if ~isfloat(img)
    img=double(img);
end
if size(img,3)==1
    img=repmat(img,[1,1,3]);
end
lab=RGB2Lab(img);
filterResponses=[];
i=1;
while(i<=size(filterBank,1))
    filterResponses(:,:,3*(i-1)+1)=imfilter(lab(:,:,1),filterBank{i});
    filterResponses(:,:,3*(i-1)+2)=imfilter(lab(:,:,2),filterBank{i});
    filterResponses(:,:,3*(i-1)+3)=imfilter(lab(:,:,3),filterBank{i});
    i=i+1;
end
end
