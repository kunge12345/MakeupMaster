function biharmonic_eqn_plot(axis_handle, xlim, dx, ylim, dy)
% function biharmonic_eqn_plot(axis_handle, xlim, dx, ylim, dy)
%
% This function displays the biharmonic equation that is used in thin plate
% spline image warping.
%
% Example:
% biharmonic_eqn_plot(gca, [-1 1], .1);
%
% Dr. A. I. Hanna (2005)
if nargin<1
    axis_handle = gca;
    xlim = [-1 1];
    dx = .1;
    ylim = [-1 1];
    dy = .1;
end
if nargin<3
    dx =.1
    ylim = xlim;
    dy = dx;
end
if nargin<4
    ylim = xlim;
    dy = dx;
end
if nargin<5
    dy = dx;
end
[x, y] = meshgrid(xlim(1):dx:xlim(2), ylim(1):dy:ylim(2));
r = sqrt(x.^2 + y.^2);
U = -r.^2.*log(r.^2);
mesh(axis_handle, x, y, U);
axis(axis_handle, 'equal', 'xy', 'vis3d');
xlabel('x');
ylabel('y');
zlabel('U(r)');
title(sprintf('-U(r) = -r^2log(r^2), r = (x^2 + y^2)^{1/2}'));
%cameratoolbar;