function [outimg] = combi( img,img_face,img_mouth,mark,standard)
%COMBI Summary of this function goes here
%   Detailed explanation goes here
fiducial_leftbrow=[29,30,31,32,33,36,35,34]+1;
fiducial_rightbrow=[75,76,77,78,79,82,81,80]+1;
fiducial_check=[1,2,3,4,5,6,7,8,9,0,18,17,16,15,14,13,12,11,10]+1;
fiducial_nose=[62,63,64,58,57,61,56,60]+1;


fiducial_mouth_UP=[37,49,48,54,51,52,46,53,47,50]+1;
fiducial_mouth_LO=[37,40,41,38,44,43,46,42,45,39]+1;

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

iP_standard_LO = zeros(size(fiducial_LO,2),2);
for  m = 1: size(fiducial_LO,2)
    j=fiducial_LO(m);
    P=[standard(j,1)*imW/100 standard(j,2)*imH/100];
    iP_standard_LO(m,:) = P;
end

iP_standard_mouth_UP = zeros(size(fiducial_mouth_UP,2),2);
for  m = 1: size(fiducial_mouth_UP,2)
    j=fiducial_mouth_UP(m);
    P=[standard(j,1)*imW/100 standard(j,2)*imH/100];
    iP_standard_mouth_UP(m,:) = P;
end

iP_standard_mouth_LO = zeros(size(fiducial_mouth_LO,2),2);
for  m = 1: size(fiducial_mouth_LO,2)
    j=fiducial_mouth_LO(m);
    P=[standard(j,1)*imW/100 standard(j,2)*imH/100];
    iP_standard_mouth_LO(m,:) = P;
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

iP_LO = zeros(size(fiducial_LO,2),2);
for  m = 1: size(fiducial_LO,2)
    j=fiducial_LO(m);
    P=[mark(j,1)*imW/100 mark(j,2)*imH/100];
    iP_LO(m,:) = P;
end

iP_mouth_UP = zeros(size(fiducial_mouth_UP,2),2);
for  m = 1: size(fiducial_mouth_UP,2)
    j=fiducial_mouth_UP(m);
    P=[mark(j,1)*imW/100 mark(j,2)*imH/100];
    iP_mouth_UP(m,:) = P;
end

iP_mouth_LO = zeros(size(fiducial_mouth_LO,2),2);
for  m = 1: size(fiducial_mouth_LO,2)
    j=fiducial_mouth_LO(m);
    P=[mark(j,1)*imW/100 mark(j,2)*imH/100];
    iP_mouth_LO(m,:) = P;
end

mask_UP = imread('UP.bmp');
mask_MI = imread('MI.bmp');
mask_LO = imread('LO.bmp');

mask_mouth_UP = imread('UP_M.bmp');
mask_mouth_LO = imread('LO_M.bmp');

outimg = img;

[wimg, ~, ~] = TPS_im_warp(img, img_face, iP_UP , iP_standard_UP);
[wmask_u, ~, ~] = TPS_im_warp(img, mask_UP, iP_UP , iP_standard_UP);
for i=1:imH
    index = find(wmask_u(i,:)~=0);
    if isempty(index)==0
        outimg(i,index,1) = wimg(i,index,1);
        outimg(i,index,2) = wimg(i,index,2);
        outimg(i,index,3) = wimg(i,index,3);
    end
end

[wimg, ~, ~] = TPS_im_warp(img, img_face, iP_MI , iP_standard_MI);
[wmask_m, ~, ~] = TPS_im_warp(img, mask_MI, iP_MI , iP_standard_MI);
for i=1:imH
    index = find(wmask_m(i,:)~=0);
    if isempty(index)==0
        outimg(i,index,1) = wimg(i,index,1);
        outimg(i,index,2) = wimg(i,index,2);
        outimg(i,index,3) = wimg(i,index,3);
    end
end

[wimg, ~, ~] = TPS_im_warp(img, img_face, iP_LO , iP_standard_LO);
[wmask_l, ~, ~] = TPS_im_warp(img, mask_LO, iP_LO , iP_standard_LO);
for i=1:imH
    index = find(wmask_l(i,:)~=0);
    if isempty(index)==0
        outimg(i,index,1) = wimg(i,index,1);
        outimg(i,index,2) = wimg(i,index,2);
        outimg(i,index,3) = wimg(i,index,3);
    end
end

[wimg, ~, ~] = TPS_im_warp(img, img_mouth, iP_mouth_UP , iP_standard_mouth_UP);
[wmask, ~, ~] = TPS_im_warp(img, mask_mouth_UP, iP_mouth_UP , iP_standard_mouth_UP);
for i=1:imH
    index = find(wmask(i,:)~=0);
    if isempty(index)==0
        index_m = find(wmask_m(i,:)~=0);
        idx=intersect(index,index_m);
        if isempty(idx)==1
            outimg(i,index,1) = wimg(i,index,1);
            outimg(i,index,2) = wimg(i,index,2);
            outimg(i,index,3) = wimg(i,index,3);
        else
            outimg(i,idx,1) = wimg(i,idx,1)*0.5+outimg(i,idx,1)*0.5;
            outimg(i,idx,2) = wimg(i,idx,2)*0.5+outimg(i,idx,2)*0.5;
            outimg(i,idx,3) = wimg(i,idx,3)*0.5+outimg(i,idx,3)*0.5;
            index=setdiff(index,idx);
            outimg(i,index,1) = wimg(i,index,1);
            outimg(i,index,2) = wimg(i,index,2);
            outimg(i,index,3) = wimg(i,index,3);
        end
    end
end

[wimg, ~, ~] = TPS_im_warp(img, img_mouth, iP_mouth_LO , iP_standard_mouth_LO);
[wmask, ~, ~] = TPS_im_warp(img, mask_mouth_LO, iP_mouth_LO , iP_standard_mouth_LO);
for i=1:imH
    index = find(wmask(i,:)~=0);
    if isempty(index)==0
        index_l = find(wmask_l(i,:)~=0);
        idx=intersect(index,index_l);
        if isempty(idx)==1
            outimg(i,index,1) = wimg(i,index,1);
            outimg(i,index,2) = wimg(i,index,2);
            outimg(i,index,3) = wimg(i,index,3);
        else
            outimg(i,idx,1) = wimg(i,idx,1)*0.5+outimg(i,idx,1)*0.5;
            outimg(i,idx,2) = wimg(i,idx,2)*0.5+outimg(i,idx,2)*0.5;
            outimg(i,idx,3) = wimg(i,idx,3)*0.5+outimg(i,idx,3)*0.5;
            index= setdiff(index,idx);
            outimg(i,index,1) = wimg(i,index,1);
            outimg(i,index,2) = wimg(i,index,2);
            outimg(i,index,3) = wimg(i,index,3);
        end
    end
end

outimg=uint8(outimg);

end

