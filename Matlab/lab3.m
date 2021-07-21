% clc
% clear all
% close all

s=5;
w=1;

image = imread("Mars.jpg");
imshow(image);
figure();
part1
imshow(meanSubtraction(image,s,w));
% part2
% edges = edge(image,'sobel');

