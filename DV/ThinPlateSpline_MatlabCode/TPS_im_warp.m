function [wimg, w, a] = TPS_im_warp(target,img, ipts, opts)
% function [wimg, w, a] = TPS_im_warp(img, ipts, opts)
%
% This function implements the THIN PLATE SPLINE method of image warping.
% 
% Input Params:
%  target - the image size warped to
%  img - the image to be warped
%  ipts - the set of input pts that the image is to be warped to
%  opts - the set of input pts that the image is already registered to
%
% Dr. A. I. Hanna (2006).
[w, a, K] = pts2TPS_param(opts, ipts);
%wimg = zeros(ceil(max(ipts(:,2))), ceil(max(ipts(:,1))), size(img,3));
wimg = zeros(size(target,1), size(target,2), size(img,3));
size(img,1);
for i=1:size(wimg,2)
    tps = psi_tps([i*ones(size(wimg,1),1),(1:size(wimg,1))'], a, w, ipts);
    tps_x = round(tps(:,1)); tps_y = round(tps(:,2));
    for ii=1:length(tps_x)
        if (tps_x(ii))>0 & (tps_x(ii) < size(img,2)) & (tps_y(ii)>0) & (tps_y(ii)<size(img,1))
            wimg(ii, i, :) = img(tps_y(ii), tps_x(ii), :);
        end
    end
    %fprintf('.'); if mod(i, 50)==0; fprintf('\n'); end;
end
%fprintf('\n');
wimg = uint8(wimg);
return;