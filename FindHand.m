function [ bounding_box ] = FindHand( image_path, background_image)
%FindHand Finds the hand in the image
%   Input: the full path of the image, a background image to use for
%   subtraction
%   Output: the bounding box surrounding the hand

image = imread(image_path, 'jpg');
background = imread(background_image, 'jpg');

[MR,MC,Dim] = size(background);

foreground = zeros(MR, MC);

foreground = (abs(image(:,:,1) - background(:,:,1)) > 5) ...
    | (abs(image(:,:,2) - background(:,:,2)) > 5) ...
    | (abs(image(:,:,3) - background(:,:,3)) > 5);

% figure, imshow(foreground)

se = strel('disk', 8);
eroded = imopen(foreground, se);
% figure, imshow(eroded)

labeled = bwlabel(eroded, 4);
stats = regionprops(labeled, ['basic']);
[N,W] = size(stats);

if N < 1
    bounding_box = [0,0,0,0];
    return
end

id = zeros(N);
for i = 1 : N
    id(i) = i;
end
for i = 1 : N-1
    for j = i+1 : N
      if stats(i).Area < stats(j).Area
        tmp = stats(i);
        stats(i) = stats(j);
        stats(j) = tmp;
        tmp = id(i);
        id(i) = id(j);
        id(j) = tmp;
      end
      
    end
end
% make sure that there is at least 1 big region
%   if stats(1).Area < 100 
%     return
%   end

bounding_box = stats(1).BoundingBox;

figure, imshow(image)
% figure, imshow(foreground)
rectangle('Position', bounding_box,'EdgeColor','b');

end

