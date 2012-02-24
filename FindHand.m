function [ bounding_box ] = FindHand( image_path, background_image)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

image = imread(image_path, 'jpg');
background = imread(background_image, 'jpg');

[MR,MC,Dim] = size(background);

foreground = zeros(MR, MC);

foreground = (abs(image(:,:,1) - background(:,:,1)) > 10) ...
    | (abs(image(:,:,2) - background(:,:,2)) > 10) ...
    | (abs(image(:,:,3) - background(:,:,3)) > 10);

eroded = bwmorph(foreground, 'erode', 2);
dilate = bwmorph(eroded, 'dilate', 2);

labeled = bwlabel(dilate, 4);
stats = regionprops(labeled, ['basic']);

bounding_box = stats.BoundingBox

figure, imshow(image)
rectangle('Position', bounding_box,'EdgeColor','b');

end

