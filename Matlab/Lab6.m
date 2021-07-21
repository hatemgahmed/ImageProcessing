clc
clear all
close all

I48 = imread('Dataset\Frame148.jpg');
I49 = imread('Dataset\Frame149.jpg');
diff=(I49-I48);
figure, imshow(diff>=10);
figure, imshow(diff>=20);

figure, imshow(BGMean(20,5,5));
figure, imshow(BGMean(100,5,5));
figure, imshow(BGMean(100,5,3));

figure, imshow(BGMedian(20,5,5));
figure, imshow(BGMedian(100,5,5));
figure, imshow(BGMedian(100,5,3));
