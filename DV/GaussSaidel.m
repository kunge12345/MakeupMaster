function [ X ] = GaussSaidel( b,d_a,d_row,d_colum,imH,imW)
%GAUSSSAIDEL Summary of this function goes here
%   Detailed explanation goes here
X=uint8(zeros(size(b)));
x=zeros(imH*imW,1);
y=zeros(imH*imW,1);
temp=zeros(imH*imW,1);

for k=1:100000
    for i=1:size(b,1)
        sum = 0;
        if d_a((d_row(i)-2)*imW+d_colum(i))~=0
            sum=sum-temp((d_row(i)-2)*imW+d_colum(i));
        end
        if d_a(d_row(i)*imW+d_colum(i))~=0
            sum=sum-temp(d_row(i)*imW+d_colum(i));
        end
        if d_a((d_row(i)-1)*imW+d_colum(i)-1)~=0
            sum=sum-temp((d_row(i)-1)*imW+d_colum(i)-1);
        end
        if d_a((d_row(i)-1)*imW+d_colum(i)+1)~=0
            sum=sum-temp((d_row(i)-1)*imW+d_colum(i)+1);
        end
        
        y(i)=(b(i)-sum)/4;
        temp((d_row(i)-1)*imW+d_colum(i))=y(i);
        
    end
    
    eps=abs(y(1)-x(1));
    for i=1:size(b,1)
        if eps < abs(y(i)-x(i))
            eps= abs(y(i)-x(i));
        end
    end
    
    if eps<0.001
        break;
    else
        for i=1:size(b,1)
            x(i)=y(i);
        end
    end
end

for i=1:size(b,1)
    if x(i)>255
        X(i,1)=255;
    elseif x(i)<0
        X(i,1)=0;
    else
        X(i,1)= uint8(x(i));
    end
end
end

