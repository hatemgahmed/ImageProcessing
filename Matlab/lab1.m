clc
clear all
close all
image = imread("Football_Noise.bmp");
figure();
reflected = reflectxy(image);
imshow(reflected);
figure();
filtered=medianFilterimplemented(reflected,3);
imshow(filtered);
filtered2=medianFilterimplemented(reflected,21);
figure();
imshow(filtered2);
figure();
grayscale=toGrayscale(filtered);
imshow(grayscale);
figure();
foreground=optimalThresholding(grayscale);
imshow(foreground);
figure();
grayscale=toGrayscale(filtered2);
imshow(grayscale);
figure();
foreground=optimalThresholding(grayscale);
imshow(foreground);
