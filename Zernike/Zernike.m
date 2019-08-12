function [oimg,X,Y]=BaseZernike1(img)
load M2;     %获取模板,7*7的
%卷积运算
Z00=conv2(M00,img);
Z11I=conv2(M11I,img);
Z11R=conv2(M11R,img);
Z20=conv2(M20,img);
Z31I=conv2(M31I,img);
Z31R=conv2(M31R,img);
Z40=conv2(M40,img);
%截掉多余部分
Z00=Z00(4:end-3,4:end-3);
Z11I=Z11I(4:end-3,4:end-3);
Z11R=Z11R(4:end-3,4:end-3);
Z20=Z20(4:end-3,4:end-3);
Z31I=Z31I(4:end-3,4:end-3);
Z31R=Z31R(4:end-3,4:end-3);
Z40=Z40(4:end-3,4:end-3);
%设置k，oimg，theta，Zz11，l等的初始矩阵，以防后来矩阵运算大小不匹配。
k=zeros(size(img,1),size(img,2));
oimg=k;
theta=k;
theta31=k;
Zz11=k;
Zz31=k;
z11=k;
z31=k;
Zz40=k;
Zz20=k;
h=k;
bounder=k;
l=100*ones(size(img,1),size(img,2));
l1=100*ones(size(img,1),size(img,2));
l2=100*ones(size(img,1),size(img,2));
%         防止分子、分母均为0而产生的NAN
a=abs(Z11R)<0.0001;
b=abs(Z11I)<0.0001;
c=a&b;Z11R(c)=1;Z11I(c)=1;
theta=atan(Z11I./Z11R);
g=abs(Z31R)<0.0001;
j=abs(Z31I)<0.0001;
f=g&j;Z31R(f)=1;Z31I(f)=1;
theta31=atan(Z31I./Z31R);

Zz11=Z11R.*cos(theta)+Z11I.*sin(theta);
Zz31=Z31R.*cos(theta31)+Z31I.*sin(theta31); 
Zz20=Z20;
Zz40=Z40;
l1=sqrt((5*Zz40+3*Zz20)./(8*Zz20));
l2=sqrt((5*Zz31+Zz11)./(6*Zz11));
l=(l2+l1)/2;
 e=abs(l)>1/(3.5*sqrt(2));
 k=1.5.*Zz11./((1-l2.^2).^1.5);
 k(e)=0;
 h=(Z00-(k*pi)/2+k.*asin(l2)+k.*l2.*sqrt(1-l2.^2))./pi;
a=abs(l2-l1)<1;
 b=abs(k)>=1.7;
%b=abs(k)>max(img(:))/10;
% amp=sqrt(Z11R.^2+Z11I.^2);
%  t=amp>15;
% a,b分别为距离和边缘强度判断结果,c为之前需要去掉的NAN部分
 %d=a&b&t&~c&~f;
d=a&b&~c&~f;
oimg(d)=1;
bounder(3:end-2,3:end-2)=1;
oimg(~bounder)=0;

figure,imshow(oimg);
