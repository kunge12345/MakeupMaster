function [outimg] = PoissonMask(standard,img,mark)
%EXTRACTFACIAL Summary of this function goes here
%   Detailed explanation goes here

fiducial_lefteye=[21,22,19,23,25,28,26,27]+1;
fiducial_righteye=[67,68,65,69,71,74,72,73]+1;
fiducial_leftbrow=[29,30,31,32,33,36,35,34]+1;
fiducial_rightbrow=[75,76,77,78,79,82,81,80]+1;
fiducial_check=[1,2,3,4,5,6,7,8,9,0,18,17,16,15,14,13,12,11,10]+1;

fiducial= zeros(1,51);
for n = 1:8
    fiducial(n)=fiducial_lefteye(n);
end
for n = 1:8
    fiducial(n+8)=fiducial_righteye(n);
end
for n = 1:8
    fiducial(n+16)=fiducial_leftbrow(n);
end
for n = 1:8
    fiducial(n+24)=fiducial_rightbrow(n);
end
for n = 1:19
    fiducial(n+32)=fiducial_check(n);
end


imW=260;
imH=300;

iP_standard = zeros(size(fiducial,2),2);
for m = 1: size(fiducial,2)
    j=fiducial(m);
    P=[standard(j,1)*imW/100 standard(j,2)*imH/100];
    iP_standard(m,:) = P;
end


imW=size(img,2);
imH=size(img,1);

iP = zeros(size(fiducial,2),2);
for m = 1: size(fiducial,2)
    j=fiducial(m);
    P=[mark(j,1)*imW/100 mark(j,2)*imH/100];
    iP(m,:) = P;
end


mask = imread('pmask1.bmp');

outimg = zeros(size(img,1),size(img,2),size(img,3));

imW=size(img,2);
imH=size(img,1);

[wimg, ~, ~] = TPS_im_warp(img, mask, iP, iP_standard);
% for i=1:imH
%     index = find(mask(i,:)~=0);
%     if isempty(index)==0
%         outimg(i,index,1) = wimg(i,index,1);
%         outimg(i,index,2) = wimg(i,index,2);
%         outimg(i,index,3) = wimg(i,index,3);
%     end
% end



outimg=uint8(wimg);

end

