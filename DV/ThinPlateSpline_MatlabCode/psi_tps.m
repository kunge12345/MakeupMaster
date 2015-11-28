function [tps] = psi_tps(u, a, w, opts)
% function [tps] = psi_tps(u, a, w, opts)
% 
% This function is the approximate warping function given by the thin plate
% spline method.
%
% Input Params:
%  u - the set of points you wish to warp
%  a, w - the parameters from pts2TPS_param
%  opts - the set of points that you are warping to
%
% Output Params:
%  tps - a Mx2 matrix of points defined by the warping function.
%
% Dr. A. I. Hanna (2006).
tps = [ones(size(u,1),1), u]*a + U_rbs(matdistance(u', opts'))*w;
