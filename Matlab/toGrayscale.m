function [output] = toGrayscale(image)

im_size=size(image);

% output=zeros(im_size(1),im_size(2),'uint8');

% image=double(image);

output=image(:,:,1)*0.3+image(:,:,2)*0.59+image(:,:,3)*0.11;

end


