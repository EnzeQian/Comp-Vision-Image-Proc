function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

    % TODO Implement your code here
    filterBank  = createFilterBank();
    a=200;
    K=300;
    collection=[];
    for i=1:length(imPaths)
    image=imread(char(imPaths(i)));
    fr=extractFilterResponses(image,filterBank);
    fr=reshape(fr,[],size(fr,3));
    index=randperm(size(fr,1),a);
    fr=fr(index,:);
    collection=[collection;fr];
    end
    [~,dictionary]=kmeans(collection,K,'EmptyAction','drop');
    dictionary=transpose(dictionary);
end
