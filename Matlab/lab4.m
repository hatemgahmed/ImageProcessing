clc
clear all
close all

I = double(imread('MarsG.jpg'))/255;
% 13x13 filter
% seg=1,thresh=0.05
[E,B,G] = log_edge(I,7,0.05);
figure()
imshow(G*255)

% seg=2,thresh=0.05
[E,B,G] = log_edge(I,13,0.05);
figure()
imshow(G*255)

% seg=1,thresh=0.4
[E,B,G] = log_edge(I,7,0.4);
figure()
imshow(G*255)





% figure
% subplot(2,2,1);
% imagesc(I); title('Image'); axis equal tight; 
% subplot(2,2,2);
% imagesc(G); title('LoG Output'); axis equal tight; 
% subplot(2,2,3);
% imagesc(B); axis equal tight; title('LoG Filter');
% subplot(2,2,4);
% imagesc(E); title('Edges'); axis equal tight; 
% colormap(gray);
% drawnow;