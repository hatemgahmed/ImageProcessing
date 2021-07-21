function [output] = meanFilter(image,l)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

im_size=size(image);
half=(l-1)/2;
output=zeros(im_size(1)-half*2,im_size(2)-half*2,im_size(3),'uint8');

    for channel = 1:im_size(3)

       for i=half+1:im_size(1)-half

           for j=half+l:im_size(2)-half

               output(i-half,j-half,channel) = mean_implemented(reshape(image(i-half:i+half,j-half:j+half,channel),[l*l,1]));
           end
       end

    end

end


