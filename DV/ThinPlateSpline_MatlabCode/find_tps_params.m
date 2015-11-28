scale = 1;
ipts = load('ipts');
ipts = ipts.ipts;
opts = load('opts');
opts = opts.opts;
img = imread('Cropped\Leo12.jpg');
ipts = ipts*scale;
opts = opts*scale;
img = imresize(img, scale);



imagesc(img); hold on;
plot(ipts(:,1), ipts(:,2), 'bo');

[w, a] = pts2TPS_param(ipts, opts)



wimg = zeros(size(img));
size(img,1)
for i=1:size(img,1)
    for ii=1:size(img,2)
        tps_x = round(psi_tps([i,ii], a(:,1), w(:,1), ipts));
        tps_y = round(psi_tps([i,ii], a(:,2), w(:,2), ipts));
        if (tps_x)>0 & (tps_x < size(img,1)) & (tps_y>0) & (tps_y<size(img,2))
            wimg(tps_y, tps_x, :) = img(ii, i, :);
        else
            wimg(i, ii,:) = 0;
        end
    end
    i
end
wimg = uint8(wimg);


u = ipts(1,:);

tps_x = psi_tps(ipts, a(:,1), w(:,1), ipts);
tps_y = psi_tps(ipts, a(:,2), w(:,2), ipts);

error = sqrt(sum((opts - [tps_x', tps_y']).^2,2));
error = sum(error)/length(error)

close all;
figure(1);
subplot(1,2,1); hold on;
imagesc(img);
plot(ipts(:,1), ipts(:,2), 'go');
axis image ij;
subplot(1,2,2); hold on;
imagesc(wimg);
plot(opts(:,1), opts(:,2), 'rd');
plot(tps_x, tps_y, 'go');

axis image ij;

