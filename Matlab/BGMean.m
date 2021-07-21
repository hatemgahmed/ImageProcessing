function out = BGMean(KFrames,Thresh,morph)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
images=zeros(240,360,KFrames);
for i=1:KFrames
    images(:,:,i)=double(imread("Dataset\Frame"+i+".jpg"));
end
BG = mean(images,3);
% out=BG;
% figure,imshow(BG);
im = double(imread('Dataset\Frame148.jpg'));
diff = uint8(abs(BG-im));
diff=diff>=Thresh;
se = strel('square',morph);
out = imclose(diff,se);
out = imopen(out,se);
end

