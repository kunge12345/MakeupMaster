function [ imnew ] = SeamlessCloning(im, iminsert, imMask)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

img = cell(3);
imgin = cell(3);
[img{1}, img{2}, img{3}] = decomposeRGB(im);
[imgin{1}, imgin{2}, imgin{3}] = decomposeRGB(iminsert);
if size(size(imMask))==2
    imMask = rgb2gray(imMask);
end


parfor i=1:3
    imgin{i} = poissonMixed(img{i}, imgin{i}, imMask);
end

imnew = composeRGB(imgin{1}, imgin{2}, imgin{3});

figure(100);

% poisson1(50, 51, 5);


% im = double(imread('../images/test001BW.tif', 'TIFF'));
% figure;
% imshow(mat2gray(im));

end

