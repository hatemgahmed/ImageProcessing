function rgb = removeShadows(img)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
figure,imshow(img);
img=imadjust(img,[],[],0.5);
y=rgb2ycbcr(img);

maskThresh=130;

% Processing
y(y(:,:,1)>maskThresh)=0;
rgb = ycbcr2rgb(y);
% rgb(rgb(:,:,3)>20)=0;
rgb(rgb(:,:,3)<maskThresh)=0;
% rgb(rgb(:,:,1)*rgb(:,:,3)==0)=0;
% k=(rgb(:,:,3)<rgb(:,:,2)+rgb(:,:,1));
mask=rgb(:,:,3)>maskThresh;
y=rgb2ycbcr(img);
brightness = y(:,:,1);
mult=1.2;
div=1.25;
% figure,imshow(mask);
brightness(mask)=brightness(mask)*mult;
y(:,:,1)=brightness;
rgb = ycbcr2rgb(y);
% blue=rgb(:,:,3);
% blue(mask)=blue(mask)/div;
% rgb(:,:,3) = blue;
% green=rgb(:,:,2);
% green(mask)=green(mask)/div;
% rgb(:,:,2) = green;
figure,imshow(rgb);

end

