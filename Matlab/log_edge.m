function [E,F,G] = log_edge(I,N,t)
% inputs : I - image, N - size of filter 
% outputs: E - edge image, F - filter
if (nargin<2)
  N=5;
end
% force I to be a NxN real number array, and create the laplacian of gaussians filter. Note that F sums to zero has has total energy = 1.
I=double(I(:,:,1));
if (N<=3)
  F=[0 1 0; 1 -4 1; 0 1 0]/8;
else
  F = fspecial('log',N,floor((N-1)/3)/2);
end
% 1. Create and emtpy array E and and an array G containing the filtered image.
E = zeros(size(I));
G = conv2(I,F,'same');

% % TO PREVENT THE THRESHOLD GOING TOO LOW FOR SMALL FILTER SIZES 3,5,7,9 etc 
% threshK=max(1,-0.5*N+7.5); % multiply threshold by this factor
% % 2. compute threshold t (0.75*mean(G)) of the LoG image stored in G (and multiply by threshK)
% t = 0.75*mean(G(:))*threshK;

% 3. identify the zero crossing points 
[r, c] = size(I);
for i= 2:r-1
    for j = 2:c-1
        if I(i,j-1)>0
% 4. preserve those zero crossing points where the sum of the magnitudes of G accross the zero crossing is > t
           res = abs(j+(j-1));
          if res>t
           E(i,j) = res;
          end
       end
       
       if I(i-1,j)>0
           res = abs(j+(j-1));
           if res>t
           E(i,j) = res;               
           end
       end
       
       if I(i,j+1)>0
           res = abs(j-(j-1));
           if res>t
           E(i,j) = res;
           end
       end
       
       if I(i+1,j)>0
           res = abs(j+(j-1));
           if res>t
           E(i,j) = res;           
           end
       end
       
        
    end
end
return