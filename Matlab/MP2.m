clc
clear all
close all

I = imread('86.jpg');
I = toGrayscale(I);
I=double(I);
ft = fft2(I);
logAmplitude = abs(ft);
logAmplitude = log(logAmplitude);
phase=angle(ft);
filtered=medfilt2(logAmplitude,[7 7],'symmetric');
spectralResidual = logAmplitude - filtered;

filtered2 = medfilt2(logAmplitude,[50 50],'symmetric');
spectralResidual2 = logAmplitude - filtered2;

% Difference between the two images is the existance of lines
% coming out of the corners of the 50x50 filter

imshow((spectralResidual));
figure();
imshow((spectralResidual2));

spectPlusPhase=j*phase+spectralResidual;
step12 = exp(spectPlusPhase);

step13 = ifft2(step12);
step14 = abs(step13).^2;
step15 = imfilter(step14,fspecial('disk',15));
figure()
imshow(mat2gray(step15))