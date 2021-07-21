clc
clear all
close all

% Part 1

% X = [1 1;1 2; 2 1; 10 10; 10 11; 11 10];
% y= X'
% plot(X(:,1),X(:,2),'.');
% title 'Data K-means k=3';
% k=3;
% [IDX,C] = kmeans (X,k);
% scatterplot(C);
% title 'Centeres K-means k=3';\

% Part 2 

image = imread("Objects.bmp");
grayscale=toGrayscale(image);
% figure,imshow(grayscale);
[row,col]=size(grayscale);

% Part 3
minQ=10000000;
k=0;
ks=[0 0 0 0 0 0 0 0 0];
for i=2:10
    [Cluster,Centers] = kmeans(reshape(double(grayscale),row*col,1),i);
    Q=kmeans_Q(Cluster,Centers,grayscale);
    ks(i)=Q;
    if Q<minQ
        minQ=Q;
        k=i;
    end
end
plot(ks);
k
