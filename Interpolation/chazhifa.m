clear;
tic
%img = imread('pic3.png');
%% roi
image=imread('pic3.png');
img=image;
% img = imresize(image,0.4);
% img = image(1200:1500,1400:1900);
if numel(size(img))==3
    img = rgb2gray(img);
end
BW = edge(img,'sobel',0.06);
[row, col] = find( BW ~= 0 ); 
Row=size(BW,1);
Col=size(BW,2);
A=[row';col']';
%% 2
BW2=[];
H=[];
for k=1:1:size(col,1)
        for i=A(k,1)
        for j=A(k,2)
            if size(BW,1)-4>i && i>4 && size(BW,2)-4>j && j>4
                
                s0=0;
                s1=0;
                s2=0;
                s3=0;
                    for m=-2:1:2
                        for n=-2:1:2 
                        s0=s0+abs(BW(i+m,j)-BW(i+n,j));
                        s1=s1+abs(BW(i+m,j+m)-BW(i+n,j+n));
                        s2=s2+abs(BW(i,j+m)-BW(i,j+n));
                        s3=s3+abs(BW(i-m,j+m)-BW(i-n,j+n));
                        end
                    end
                    s=[s0 s1 s2 s3];
                    [max1,index]=max(s);
                    index=index-1;
                    if index==0
                            y11=Newton([i-4,i-3,i-2,i-1],[BW(i-4,j),BW(i-3,j),BW(i-2,j),BW(i-1,j)],[i-2.5]);
                            y21=Newton([i+1,i+2,i+3,i+4],[BW(i+1,j),BW(i+2,j),BW(i+3,j),BW(i+4,j)],[i+2.5]);
                            Gradient=(BW(i-1,j)-BW(i+1,j))/2;
                            result = Hermite([i-2.5,i,i+2.5],[y11,BW(i,j),y21],Gradient);
                            result=double(result);
                            H=[H,result];
                            BW2=[BW2;[i+result,j,1,0]];
                            
                    elseif index==1
                            y11=Newton([j-4,j-3,j-2,j-1],[BW(i+4,j-4),BW(i+3,j-3),BW(i+2,j-2),BW(i+1,j-1)],[j-2.5]);
               
                            y21=Newton([j+1,j+2,j+3,j+4],[BW(i-1,j+1),BW(i-2,j+2),BW(i-3,j+3),BW(i-4,j+4)],[j+2.5]);
                            Gradient=(BW(i+1,j-1)-BW(i-1,j+1))/2;
                            result = Hermite([j-2.5,j,j+2.5],[y11,BW(i,j),y21],Gradient);
                            result=double(result);
                            H=[H,result];
                            BW2=[BW2;[i-result,result+j,0.7071,-0.7071]];
                    elseif index==2
                            y11=Newton([j-4,j-3,j-2,j-1],[BW(i,j-4),BW(i,j-3),BW(i,j-2),BW(i,j-1)],[j-2.5]);
                            y21=Newton([j+1,j+2,j+3,j+4],[BW(i,j+1),BW(i,j+2),BW(i,j+3),BW(i,j+4)],[j+2.5]);
                            Gradient=(BW(i,j-1)-BW(i,j+1))/2;
                            result = Hermite([j-2.5,j,j+2.5],[y11,BW(i,j),y21],Gradient);
                            result=double(result);
                            H=[H,result];
                            BW2=[BW2;[i,result+j,0,1]];
                    elseif index==3

                            y11=Newton([j-4,j-3,j-2,j-1],[BW(i-4,j-4),BW(i-3,j-3),BW(i-2,j-2),BW(i-1,j-1)],[j-2.5]);
                            y21=Newton([j+1,j+2,j+3,j+4],[BW(i+1,j+1),BW(i+2,j+2),BW(i+3,j+3),BW(i+4,j+4)],[j+2.5]);
                            Gradient=(BW(i-1,j-1)-BW(i+1,j+1))/2;
                            result = Hermite([j-2.5,j,j+2.5],[y11,BW(i,j),y21],Gradient);
                            result=double(result);
                            H=[H,result];
                            BW2=[BW2;[i+result,j+result,0.7071,0.7071]];
                     end
            else 
                
            end
        end
    end
end

imshow('pic3.png','InitialMagnification', 'fit');
hold on
seg = 0.6;
% BW2(:,1)=BW2(:,1)+1400.0;
% BW2(:,2)=BW2(:,2)+1200.0;
quiver(BW2(:,2)-seg/2*BW2(:,4), BW2(:,1)+seg/2*BW2(:,3), seg*BW2(:,4), -seg*BW2(:,3), 0, 'r');
quiver(BW2(:,2),BW2(:,1),BW2(:,3),BW2(:,4),0, 'b.');
toc











                
                
        











