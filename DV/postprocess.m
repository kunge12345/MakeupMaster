function [ outimg ] = postprocess(img,newimg,mark,standard)
%POSTPROCESS Summary of this function goes here
%   Detailed explanation goes here
newimg=uint8(newimg);
fiducial_leftbrow=[29,30,31,32,33,36,35,34]+1;
fiducial_rightbrow=[75,76,77,78,79,82,81,80]+1;
fiducial_check=[1,2,3,4,5,6,7,8,9,0,18,17,16,15,14,13,12,11,10]+1;
fiducial_nose=[62,63,64,58,57,61,56,60]+1;

fiducial_UPline=[1,21,27,26,28,25,55,59,67,73,72,74,71,10]+1;
fiducial_MIUline=[1,21,22,19,23,25,55,59,67,68,65,69,71,10]+1;
fiducial_MILline=[6,37,49,48,54,51,52,46,15]+1;
fiducial_LOline=[6,37,40,41,38,44,43,46,15]+1;


fiducial_UP=zeros(1,30);
for n = 1:14
    fiducial_UP(n)=fiducial_UPline(n);
end
for n = 1:8
    fiducial_UP(n+14)=fiducial_leftbrow(n);
end
for n = 1:8
    fiducial_UP(n+22)=fiducial_rightbrow(n);
end


fiducial_MI=zeros(1,39);
for n = 1:14
    fiducial_MI(n)=fiducial_MIUline(n);
end
for n = 1:4
    fiducial_MI(n+14)=fiducial_check(n+1);
end
for n = 1:4
    fiducial_MI(n+18)=fiducial_check(n+14);
end
for n = 1:9
    fiducial_MI(n+22)=fiducial_MILline(n);
end
for n = 1:8
    fiducial_MI(n+31)=fiducial_nose(n);
end

fiducial_LO=zeros(1,16);
for n = 1:9
    fiducial_LO(n)=fiducial_LOline(n);
end
for n = 1:7
    fiducial_LO(n+9)=fiducial_check(n+6);
end

imW=260;
imH=300;

iP_standard_UP = zeros(size(fiducial_UP,2),2);
for m = 1: size(fiducial_UP,2)
    j=fiducial_UP(m);
    P=[standard(j,1)*imW/100 standard(j,2)*imH/100];
    iP_standard_UP(m,:) = P;
end

iP_standard_MI = zeros(size(fiducial_MI,2),2);
for m = 1:size(fiducial_MI,2)
    j=fiducial_MI(m);
    P=[standard(j,1)*imW/100 standard(j,2)*imH/100];
    iP_standard_MI(m,:) = P;
end

imW=size(img,2);
imH=size(img,1);

iP_UP = zeros(size(fiducial_UP,2),2);
for m = 1: size(fiducial_UP,2)
    j=fiducial_UP(m);
    P=[mark(j,1)*imW/100 mark(j,2)*imH/100];
    iP_UP(m,:) = P;
end

iP_MI = zeros(size(fiducial_MI,2),2);
for m = 1:size(fiducial_MI,2)
    j=fiducial_MI(m);
    P=[mark(j,1)*imW/100 mark(j,2)*imH/100];
    iP_MI(m,:) = P;
end

mask_UP = imread('UP_post.bmp');
mask_MI = imread('MI_post.bmp');

outimg = img;

[wmask_u, ~, ~] = TPS_im_warp(img, mask_UP, iP_UP , iP_standard_UP);
for i=1:imH
    index = find(wmask_u(i,:)~=0);   
    if isempty(index)==0
        idx=find(wmask_u(i,:)==0);
        outimg(i,idx,1) = outimg(i,idx,1)*0.9+newimg(i,idx,1)*0.1;
        outimg(i,idx,2) = outimg(i,idx,2)*0.9+newimg(i,idx,2)*0.1;
        outimg(i,idx,3) = outimg(i,idx,3)*0.9+newimg(i,idx,3)*0.1;
        outimg(i,index,1) = newimg(i,index,1);
        outimg(i,index,2) = newimg(i,index,2);
        outimg(i,index,3) = newimg(i,index,3); 
    end
end

[wmask_m, ~, ~] = TPS_im_warp(img, mask_MI, iP_MI , iP_standard_MI);
for i=1:imH
    index = find(wmask_m(i,:)~=0);   
    if isempty(index)==0
        idx=find(wmask_m(i,:)==0);
        outimg(i,idx,1) = outimg(i,idx,1)*0.9+newimg(i,idx,1)*0.1;
        outimg(i,idx,2) = outimg(i,idx,2)*0.9+newimg(i,idx,2)*0.1;
        outimg(i,idx,3) = outimg(i,idx,3)*0.9+newimg(i,idx,3)*0.1;
        outimg(i,index,1) = newimg(i,index,1);
        outimg(i,index,2) = newimg(i,index,2);
        outimg(i,index,3) = newimg(i,index,3); 
    end
end

outimg=uint8(outimg);
end

