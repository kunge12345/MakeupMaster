function [ outdata ] = Remove_mouth(image, mask)
%REMOVE_MOUTH Summary of this function goes here
%   Detailed explanation goes here
start_spams;

imH=size(mask,1);
imW=size(mask,2);
imsize=imH*imW;

banch = '1';
load(['MouLAB_4_',banch],'vec','par','param');
%par.win                =    130;
%par.K               =       40;
%par.L               =       150 * 130 *3;
%param.K = par.K;
%param.L = par.L;


load(['MouLAB_Dict_4_',banch]);

Dh    = Dict.DH;
Dl    = Dict.DL;
Wl    = Dict.WL;
Wh    = Dict.WH;

cls_num = size(Dh,2);

mask_gnd(1:imsize,1)= reshape(mask(:,:,1),imsize,1);
mask_gnd = double(mask_gnd);
deletind=find(mask_gnd==0);

srgb2lab = makecform('srgb2lab');
image = applycform(image, srgb2lab);
Yl_gnd(1:imsize,1)= reshape(image(:,:,1),imsize,1);
Yl_gnd(imsize+1:imsize*2,1)=reshape(image(:,:,2),imsize,1);
Yl_gnd(imsize*2+1:imsize*3,1)=reshape(image(:,:,3),imsize,1);
Yl_gnd = double(Yl_gnd);
Yh_gnd = Yl_gnd;
YH_gnd = Yh_gnd;
deletind = [deletind', deletind'+imH*imW, deletind'+imH*imW*2]';
YH_gnd(deletind)=[];

YL =  Yl_gnd;
YL(deletind)=[];
YH =  YL;

for m = 1 : 2
    fprintf('Iter: %d \n', m);
    for t=1:4;
        %if t == 1
            %[cls_idx]  = setPatchIdx(YL, vec');
            [cls_idx] = 1;
        %end
        Yl = YL - repmat(mean(YL), [par.L 1]);
        Yh = YH - repmat(mean(YH), [par.L 1]);
        i = cls_idx;
        idx_temp   = 1;%find(cls_idx == i);
        Yl    = double(Yl(:, idx_temp));
        Yh    = double(Yh(:, idx_temp));
        Dh    = Dict.DH{i};
        Dl    = Dict.DL{i};
        Wl    = Dict.WL{i};
        Wh    = Dict.WH{i};
        param.K = size(Dh,2);
        par.K=param.K;
        if (t == 1)
            Alphal = mexLasso(Yl, Dl, param);
            Alphah = Wl * Alphal;
            Yh = Dh * Alphah;
        else
            Alphah = AH{i};
        end
        D = [Dl; par.sqrtmu * Wl];
        Y = [Yl; par.sqrtmu * full(Alphah)];
        Alphal = mexLasso(Y, D,param);
        clear Y D;
        D = [Dh; par.sqrtmu * Wh];
        Y = [Yh; par.sqrtmu * full(Alphal)];
        Alphah = full(mexLasso(Y, D,param));
        clear Y D;
        Yh = Dh * Alphah;
        YH(:, idx_temp) = Yh;
        AL{i} = Alphal;
        AH{i} = Alphah;
    end
end

%reference=imread([num2str(identity),'.jpg']);
%reference = double(reference(:));
%YH = YH + repmat(mean(YL), [par.L 1]);
%     YH = YH + repmat(mean(YH_gnd)-mean(YH), [par.L 1]);
%     YH = YH+0;

%      YH(1:end/3,1) = YH(1:end/3,1) + mean(YH_gnd(1:end/3,1))-mean(YH(1:end/3,1))-20;
%      YH(end/3+1:end/3*2,1) = YH(end/3+1:end/3*2,1) + mean(YH_gnd(end/3+1:end/3*2,1))-mean(YH(end/3+1:end/3*2,1))+50;
%      YH(end/3*2+1:end,1) = YH(end/3*2+1:end,1) + mean(YH_gnd(end/3*2+1:end,1))-mean(YH(end/3*2+1:end,1))+40;
YH(1:end/3,1)=YH_gnd(1:end/3,1)*0.5+YH(1:end/3,1)*0.5;
YH(1:end/3,1) = YH(1:end/3,1) + 220-mean(YH(1:end/3,1))-80;%-42;
YH(end/3+1:end/3*2,1) = YH(end/3+1:end/3*2,1) + 130-mean(YH(end/3+1:end/3*2,1))+34;%-18;
YH(end/3*2+1:end,1) = YH(end/3*2+1:end,1) + 130-mean(YH(end/3*2+1:end,1))+17;%-14;
%     YH(1:end/3,1) = YH(1:end/3,1) + 220-mean(YH(1:end/3,1))-42;
%     YH(end/3+1:end/3*2,1) = YH(end/3+1:end/3*2,1) + 130-mean(YH(end/3+1:end/3*2,1))-18;
%     YH(end/3*2+1:end,1) = YH(end/3*2+1:end,1) + 130-mean(YH(end/3*2+1:end,1))-14;

%hgram=imhist(uint8(reference));  %????A????
%YH=histeq(uint8(YH),hgram);  %?B?????A???????

%     hist(reference)
%
%      hold on
%
%
%      hist(YH)

%addon=(mean(reference)-mean(YH));

%YH = YH + repmat(double(addon), [par.L 1]);


for i=1:3
    ans=Yl_gnd((i-1)*imH*imW+1:i*imH*imW);
    mdata(:,:,i)=reshape(ans,imH,imW);
end

for i=1:3
    ans=Yh_gnd((i-1)*imH*imW+1:i*imH*imW);
    ndata(:,:,i)=reshape(ans,imH,imW);
end

n=1;
for channal=1:3
    for i=1:imW
        for j=1:imH
            if mask(j,i)~=0
                outdata(j,i,channal)= YH(n);
                n=n+1;
            else
                outdata(j,i,channal)= 0;
            end
        end
    end
end

%nomean=mean(double(mdata(:))-double(outdata(:)));
%outdata(:,:,1)=mdata(:,:,1);%+nomean;
%outdata(:,:,2)=mdata(:,:,2)+nomean;
%outdata(:,:,3)=outdata(:,:,3)+nomean;
%     imshow([mdata,ndata,outdata]/255);

lab2srgb = makecform('lab2srgb');
mdata = applycform(uint8(mdata), lab2srgb);
ndata = applycform(uint8(ndata), lab2srgb);
outdata = applycform(uint8(outdata), lab2srgb);

for channal=1:3
    for i=1:imW
        for j=1:imH
            if mask(j,i)==0
                outdata(j,i,channal)= 0;
            end
        end
    end
end

end

