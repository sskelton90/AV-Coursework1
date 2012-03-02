function [ output_args ] = ComputeMHI( directory, start, finish )
%COMPUTEMHI Summary of this function goes here
%   Detailed explanation goes here

directory
base_location = strcat('train/', directory, '/');

bounding_box = FindAllHands(directory, start, finish);

for i=start:finish,
    s = num2str(i);
    
    if length(s) < 4
        diff = 4 - length(s);
        s = strcat(repmat('0', 1, diff), s);
    end
    
    im_name = strcat('00090.MTS', s);
    im_path = strcat(base_location, im_name, '.jpg');
    
    image = imread(im_path, 'jpg');
    
    figure, imshow(imcrop(image, bounding_box))    
end

close all
end

