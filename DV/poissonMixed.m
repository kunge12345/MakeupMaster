function [ out ] = poissonMixed(imdest, insert, imMask)
%POISSONMIXED Summary of this function goes here
%   Detailed explanation goes here
ratio = 250;
imdest = double(imdest);
insert = double(insert);
%---------------------------------------------
% sparse matrix allocation
%---------------------------------------------
d_row   = zeros(size(imMask,1),1);
d_colum = zeros(size(imMask,2),1);
d_a = zeros(size(imMask,1)*size(imMask,2),1);

n=0;
d=0;
for i=1:size(imMask,1)
    for j=1:size(imMask,2)
        d=d+1;
        if imMask(i,j)>40
            n=n+1;
            d_a(d) = 1;
            d_row(n) = i;
            d_colum(n) = j;
        else
            d_a(d) = 0;
        end      
    end
end

%---------------------------------------------
% construct the matrix here
%---------------------------------------------
count = 0;

b = zeros(n,1);
for y =1:size(imMask,1)
    for x=1:size(imMask,2)
        if imMask(y,x)>40
            count = count + 1;
            if imMask(y-1,x)<40
                b(count,1)= b(count,1)+imdest(y,x+1);
            end
            if imMask(y+1,x)<40
                b(count,1)= b(count,1)+imdest(y+2,x+1);
            end
            if imMask(y,x-1)<40
                b(count,1)= b(count,1)+imdest(y+1,x);
            end
            if imMask(y,x+1)<40
                b(count,1)= b(count,1)+imdest(y+1,x+2);
            end
            
            xd = x + 1;
            yd = y + 1;
            fpq1 = imdest(yd, xd)-imdest(yd-1, xd);
            fpq2 = imdest(yd, xd)-imdest(yd+1, xd);
            fpq3 = imdest(yd, xd)-imdest(yd, xd-1);
            fpq4 = imdest(yd, xd)-imdest(yd, xd+1);
            
            xs = x ;
            ys = y ;
            gpq1 = insert(ys, xs)-insert(ys-1, xs);
            gpq2 = insert(ys, xs)-insert(ys+1, xs);
            gpq3 = insert(ys, xs)-insert(ys, xs-1);
            gpq4 = insert(ys, xs)-insert(ys, xs+1);
            
            Vpq = 0;
            if abs(fpq1) > ratio*abs(gpq1)
                Vpq = Vpq + fpq1;
            else
                Vpq = Vpq + gpq1;
            end
            if abs(fpq2) > ratio*abs(gpq2)
                Vpq = Vpq + fpq2;
            else
                Vpq = Vpq + gpq2;
            end
            if abs(fpq3) > ratio*abs(gpq3)
                Vpq = Vpq + fpq3;
            else
                Vpq = Vpq + gpq3;
            end
            if abs(fpq4) > ratio*abs(gpq4)
                Vpq = Vpq + fpq4;
            else
                Vpq = Vpq + gpq4;
            end
            b(count,1) = b(count,1)+Vpq;
        end
    end
end

Result = GaussSaidel(b,d_a,d_row,d_colum,size(imdest,1),size(imdest,2));

imdest = uint8(imdest);
Result = uint8(Result);
count = 0;
for p=1:size(imMask,1)
    for q =1:size(imMask,2)
        if imMask(p,q)>40
            count = count + 1;
            imdest(p, q)= Result(count, 1);            
        end
    end
end
out=imdest;
end