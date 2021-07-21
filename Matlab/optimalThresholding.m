function [output] = optimalThresholding(image)

im_size=size(image);

mask=zeros(im_size(1),im_size(2),'uint8');
back=sum([image(1,1),image(1,end),image(end,1),image(end,end)]);
fore=double(sum(sum(image))-back);
fore_mean=fore/(im_size(1)*im_size(2)-4.0);
threshold=mean_implemented([back/4.0,fore_mean]);
while(1)
    meanBackground=mean_implemented(image(image<threshold));
    meanBackground
    meanForeground=mean_implemented(image(image>=threshold));
    threshold_new=mean_implemented([meanBackground,meanForeground]);
    if(threshold==threshold_new)
        break;
    end
    threshold=threshold_new;
end

output=image>=threshold;

end

