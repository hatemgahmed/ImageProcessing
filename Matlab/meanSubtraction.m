function [output] = meanSubtraction(image,s,w)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
avg = meanFilter(image,s);
im_size=size(image);
half=(s-1)/2;
image=image(1+half:im_size(1)-half,1+half:im_size(2)-half,:);
edge=image-avg;
output = image+edge*w;
end

