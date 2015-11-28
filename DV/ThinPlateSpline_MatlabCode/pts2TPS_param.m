function [w, a, K] = pts2TPS_param(ipts, opts)
% function [w, a, K] = pts2TPS_param(ipts, opts)
%
% This function calculates the parameters needed in the thin plate spline
% method.
%
% Input params:
%  ipts - the set of base points for an image;
%  opts - the set of points you want to warp an image to
%
% Output Params:
%  w, a - parameters used by psi_tps
%  K - the Euclidean distance matrix used by the radial basis function.
%
% Dr A. I. Hanna (2006).
K = K_mat(opts);
P = P_mat(opts);
L = L_mat(K, P);
Y = [ipts; zeros(3, 2)];
Q = pinv(L)*Y;
w = Q(1:size(opts,1),:);
a = Q(size(opts,1)+1:end,:);
return;