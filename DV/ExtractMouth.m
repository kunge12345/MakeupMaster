function [ outimg] = ExtractMouth(standard,img,mark)
%EXTRACTFACIAL Summary of this function goes here
%   Detailed explanation goes here


fiducial_mouth_UP=[37,49,48,54,51,52,46,53,47,50]+1;
fiducial_mouth_LO=[37,40,41,38,44,43,46,42,45,39]+1;


imW=260;
imH=300;

iP_standard_UP = zeros(size(fiducial_mouth_UP,2),2);
for m = 1: size(fiducial_mouth_UP,2)
    j=fiducial_mouth_UP(m);
    P=[standard(j,1)*imW/100 standard(j,2)*imH/100];
    iP_standard_UP(m,:) = P;
end

iP_standard_LO = zeros(size(fiducial_mouth_LO,2),2);
for  m = 1: size(fiducial_mouth_LO,2)
    j=fiducial_mouth_LO(m);
    P=[standard(j,1)*imW/100 standard(j,2)*imH/100];
    iP_standard_LO(m,:) = P;
end

imW=size(img,2);
imH=size(img,1);

iP_UP = zeros(size(fiducial_mouth_UP,2),2);
for m = 1: size(fiducial_mouth_UP,2)
    j=fiducial_mouth_UP(m);
    P=[mark(j,1)*imW/100 mark(j,2)*imH/100];
    iP_UP(m,:) = P;
end

iP_LO = zeros(size(fiducial_mouth_LO,2),2);
for  m = 1: size(fiducial_mouth_LO,2)
    j=fiducial_mouth_LO(m);
    P=[mark(j,1)*imW/100 mark(j,2)*imH/100];
    iP_LO(m,:) = P;
end

mask_UP = imread('UP_M.bmp');
mask_LO = imread('LO_M.bmp');

outimg = zeros(size(mask_UP,1),size(mask_UP,2),size(img,3));

imW=size(mask_UP,2);
imH=size(mask_UP,1);

[wimg, ~, ~] = TPS_im_warp(mask_UP, img, iP_standard_UP, iP_UP);
for i=1:imH
    index = find(mask_UP(i,:)~=0);
    if isempty(index)==0
        outimg(i,index,1) = wimg(i,index,1);
        outimg(i,index,2) = wimg(i,index,2);
        outimg(i,index,3) = wimg(i,index,3);
    end
end

[wimg, ~, ~] = TPS_im_warp(mask_LO, img, iP_standard_LO, iP_LO);
for i=1:imH
    index = find(mask_LO(i,:)~=0);
    if isempty(index)==0
        outimg(i,index,1) = wimg(i,index,1);
        outimg(i,index,2) = wimg(i,index,2);
        outimg(i,index,3) = wimg(i,index,3);
    end
end

outimg=uint8(outimg);

end

