function [x] = makeupremove(image_name)
region = [1,1];
%%%%%%%%%% Load an image %%%%%%%%%%%%%%%%
file_path = '/Users/Rivers/Documents/Python_RT/media/Image_Raw/';
%img_path_list = dir(strcat(file_path,'*.jpg'));
%img_num = length(img_path_list);%
%if img_num > 0
%    image_name = img_path_list(1).name;%
image_name =  strcat(file_path,image_name);
%end
img=imread(image_name);
if size(img,1)>800
    img=imresize(img,0.5);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%% landmark locate %%%%%%%%%%%%%
landmark=My_facepp(image_name);

mark=cell(83,2);
mat=struct2cell(landmark)';
for j=1:83
    mark(j,:)=struct2cell(mat{1,j})';
    %mark=[mark mark_temp];
end
mark=cell2mat(mark);
%fprintf(fid,'%d\n', outmat);
mark=single(mark);
save mark
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% extract facial and mouth %%%%%%%%%%
load mark.mat
load standard.mat
facialimg=ExtractFacial(standard,img,mark);
imshow(facialimg);
mouthimg=ExtractMouth(standard,img,mark);
imshow(mouthimg);
pmask = PoissonMask(standard,img,mark);
 pmask = 255-pmask;
pmask(1:4,:,1:3)=0;
pmask(end-4:end,:,1:3)=0;
pmask(:,1:4,1:3)=0;
pmask(:,end-4:end,1:3)=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%addpath(genpath('D:\Current\Smile_Decomposition\spams-matlab'))
%addpath(genpath('D:\Current\Smile_Decomposition\Utilities'))
mask_mouth=imread('mask_mouth.bmp');
mask_facial=imread('mask_face.bmp');
%%%%%%%% makeup remove %%%%%%%%%%%%%%
if region(1) == 1
    outface = Remove_facial(facialimg,mask_facial);
else
    outface = ExtractFacial(standard,img,mark);
end
if region(2) == 1
    outmouth = Remove_mouth(mouthimg,mask_mouth);
else
    outmouth = ExtractMouth(standard,img,mark);
end
imshow([uint8(outface),uint8(outmouth)]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% warp back %%%%%%%%%%%%%%%%%%
load mark.mat
load standard.mat
outcombi=combi(img,outface,outmouth,mark,standard);
imshow(outcombi);
% on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[ imnew ] = SeamlessCloning(outcombi,img,pmask);
imshow(mat2gray(imnew));
figure(2),imshow(img);
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[ postimg] = postprocess(img,imnew,mark,standard);
figure(1),imshow(postimg);
x = imfinfo(postimg);
