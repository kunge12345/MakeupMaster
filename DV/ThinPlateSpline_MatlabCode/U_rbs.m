function [U_r] = U_rbs(r)
% function [U_r] = U_rbs(r)
%
% This function is a radial basis function used in thin-plate spline
% parameter estimation.
% 
% see also: find_tps_params
%
% Dr. A. I. Hanna (2005)
r = r.^2;
r(find(r==0)) = 1;
U_r = r.*log(r);
return;