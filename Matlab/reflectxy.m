function [output] = reflectxy(image)

im_size=size(image);

output=zeros(im_size(1),im_size(2),im_size(3),'uint8');

for i = 1:im_size(3)
    
    output(:,:,i)=image(end:-1:1,end:-1:1,i);

end
end
