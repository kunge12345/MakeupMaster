clc; clear;
load landmark_MyD.mat
lsize=size(landmark,2);

%fid=fopen('D:\Current\Alignment\Facepp\Facepp-Matlab-SDK\landmark.txt','wt');
mark=zeros(lsize,166);
for i=1:lsize  
    outmat=[];
    mat=struct2cell(landmark{1,i})';
    for j=1:83
        outmat_temp=struct2cell(mat{1,j})';
        outmat=[outmat outmat_temp];       
    end
    outmat=cell2mat(outmat);
    mark(i,:)=outmat;
    %fprintf(fid,'%d\n', outmat);
end
mark=single(mark);
%fclose(fid);
% fid=fopen('landmark.txt','wt');
% for i=1:size(mark,1)
%     fprintf(fid,'%f %f',mark(i,:));
%     fprintf(fid,'\n');
% end
%save landmark.txt mark -ascii 
dlmwrite('training_MyD.txt',mark,'-append','delimiter', ' ');

