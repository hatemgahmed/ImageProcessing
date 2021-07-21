clc
clear all
close all
video=VideoReader('Simple_bouncing_balls.mp4');

firstFrame=readFrame(video);
prev=toGrayscale(firstFrame);

loc1 = 255;
loc2 = 100;
loc3 = 175;
loc4 = 0;
locs = [loc1; loc2; loc3; loc4];
finalCenters=zeros(89,2,4);
currFrame=0;
[row,col]=size(prev);
while hasFrame(video)
   currFrame=currFrame+1;
   image=readFrame(video);
   cur=toGrayscale(image);
%    imshow(cur);
   diff=abs(cur-prev);
   [Cluster,Centers] = kmeans(reshape(double(diff),row*col,1),4, 'Start',locs);
   locs=Centers;
   Cluster=reshape(Cluster,row,col);
%    sum(sum(Cluster==4))
   for i=1:4
       [x,y]=find(Cluster==i);
%        if i==4
%             [x,y]
%        end
       finalCenters(currFrame,1,i)=mean(x);
       finalCenters(currFrame,2,i)=mean(y);
   end
   prev=cur;
end
finalCenters
imshow(firstFrame);
for i=1:4
    hold on
    scatter(finalCenters(:,2,i),finalCenters(:,1,i));
%     figure();
%     plot(finalCenters(:,2,i),finalCenters(:,1,i),'-');
end