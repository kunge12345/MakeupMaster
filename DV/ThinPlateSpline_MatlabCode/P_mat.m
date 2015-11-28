function [P] = P_mat(ipts)
P = [ones(1, size(ipts,1)); ipts(:,1)'; ipts(:,2)']';
return;