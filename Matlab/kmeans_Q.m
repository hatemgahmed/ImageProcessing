function [Q] = kmeans_Q(Cluster,Centers,grayscale)
[row,col]=size(grayscale);
img=reshape(grayscale,row*col,1);
numerator=0;
for i=1:length(Centers)
    numerator=numerator+1/histc(Cluster,i)*sum((grayscale(Cluster==i)-Centers(i)).^2);
end
numerator=double(numerator)/double(length(Centers));
denominator=0;
for i=1:length(Centers)-1
    for j=i+1:length(Centers)
        denominator=denominator+(Centers(j)-Centers(i)).^2;
    end
end
den=length(Centers)*(length(Centers)-1);
denominator=double(denominator)*2/double(den);
Q=numerator/denominator;
end

