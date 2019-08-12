warning off;
tic
%% load image
url='pppic.bmp';
image = imread(url);
%% 1 resize method
image = imresize(image,0.4);
%% 2 filter method
% image = image(1200:1500,1400:1900);

%% subpixel detection
threshold = 10;
iter = 1;
[edges, RI] = subpixelEdges(image, threshold, 'SmoothingIter', iter); 

%% show image
showRestoredImage = 0;
if showRestoredImage
    imshow(RI/255,'InitialMagnification', 'fit');
else
%    image = imread(url);
    imshow(image,'InitialMagnification', 'fit');
end

%% Before filter
% edges.x=int32(edges.x);
% i=1;
% a=length(edges.x);
% alpha=0.5;
% while i~=a-1
%     if edges.x(i) == edges.x(i+1)
%         edges.nx(i)=alpha*edges.nx(i)+(1-alpha)*edges.nx(i+1);
%         edges.y(i)=alpha*edges.y(i)+(1-alpha)*edges.y(i+1);
%         edges.ny(i)=alpha*edges.ny(i)+(1-alpha)*edges.ny(i+1);
%         edges.x(i+1)=[];
%         edges.nx(i+1)=[];
%         edges.y(i+1)=[];
%         edges.ny(i+1)=[];
%         a=length(edges.x);
%         i=i+1;
%     else
%         i=i+1;
%         continue
%     end
% end  
% edges.x=double(edges.x);

%% 2 Before filter
% edges.x=int64(edges.x);
% for i=1:1:max(edges.x)
%     A=find(edges.x==i);
%     len=length(A);
%     if len>1
%         res=0;
%         res1=0;
%         res2=0;
%         for j=1:1:len
%             index=A(j);
%             res=res+(1/len)*edges.y(index);
%             res1=res1+(1/len)*edges.nx(index);
%             res2=res2+(1/len)*edges.ny(index);
%         end
%         edges.y(A(1))=res;
%         edges.ny(A(1))=res2;
%         edges.nx(A(1))=res1;
%         for j=2:1:len
%             index2=A(j);
%             edges.x(index2)=0;
%             edges.nx(index2)=0;
%             edges.y(index2)=0;
%             edges.ny(index2)=0;
%         end
%     end
% end
% edges.x(edges.x==0)=[];
% edges.y(edges.y==0)=[];
% edges.ny(edges.ny==0)=[];
% edges.nx(edges.nx==0)=[];
% 
% edges.x=double(edges.x);
%% 3 Before filter
        
% edges.x=int64(edges.x);
% index=0;
% for i=1:1:1000
%     index=[];
%     for j=1:1:length(edges.x)
%         if  i==edges.x(j)
%             index=[index j];
%         else
%             index;
%         end
%     end
%     len=length(index);
%     if len>1
%         edges.y(index(1))=1/len*edges.y(index(1));
%         edges.nx(index(1))=1/len*edges.nx(index(1));
%         edges.ny(index(1))=1/len*edges.ny(index(1));
%         for k=2:1:len
%             edges.nx(index(1))=edges.nx(index(1))+1/len*edges.nx(index(k));
%             edges.ny(index(1))=edges.nx(index(1))+1/len*edges.nx(index(k));
%             edges.y(index(1))=edges.nx(index(1))+1/len*edges.nx(index(k));
%             edges.x(index(k))=[];
%             edges.nx(index(k))=[];
%             edges.y(index(k))=[];
%             edges.ny(index(k))=[];
%         end   
%     else
%         len;
%     end
% end
% 
% % n=length(edges.x)
% % for m=490:1:n
% %     edges.x(m)=0;
% %     edges.y(m)=0;
% %     edges.nx(m)=0;
% %     edges.ny(m)=0;
% % end
%             
% 
% edges.x=double(edges.x);


%% 限值滤波+低通
% a=0.8;
% len=length(edges.x);
% b=1;
% for i=2:len
%     if edges.y(i)-edges.y(i-1)>b
%        edges.y(i)=edges.y(i-1)+b;
%     elseif edges.y(i-1)-edges.y(i)>b
%        edges.y(i)=edges.y(i-1)-b;
%     else
%        edges.y(i)=edges.y(i);
%     end
%      edges.y(i)=a*edges.y(i)+(1-a)*edges.y(i-1);
% end

%% 滑动平均
%  len = length(edges.x);
%  N=1;
%  for i=1:len-N
%      for j=1:1:N
%         edges.x(i)=edges.x(i)+edges.x(i+j);
%         edges.y(i)=edges.y(i)+edges.y(i+j);
%      end
%      edges.x(i)=1/(N+1)*edges.x(i);
%      edges.y(i)=1/N*edges.y(i);
%  end

%% Ployfit
% D=polyfit(edges.x,edges.y,90);
% edges.y=polyval(D,edges.x);

%% 卷积滤波
% K = 0.045*ones(5);
% edges.y=conv2(edges.y,K,'same')

%% filter
% a = 1;
% b = [1/4 1/4 1/4 1/4 1/4 1/4];
% edges.y = filter(b,a,edges.y);


%% 调整位置
% 
% edges.x=edges.x+1400.0;
% edges.y=edges.y+1200.0;

%% 截断
% edges.x=edges.x(150:450,1);
% edges.y=edges.y(150:450,1);
% edges.nx=edges.nx(150:450,1);
% edges.ny=edges.ny(150:450,1);


%% show edges
visEdges(edges);


toc
% max(edges.y)-min(edges.y)













