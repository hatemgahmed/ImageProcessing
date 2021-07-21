function [output] = mean_implemented(input)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
output = 0;
input=double(input);
for i=1:length(input)
    output=output+input(i);
end
output=output/length(input);
end

