function [K] = K_mat(pts)
r = matdistance(pts', pts');
K = U_rbs(r);
return;