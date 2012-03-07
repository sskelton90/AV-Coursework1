function [ output_args ] = ComputeMHI( directory, start, finish )
%COMPUTEMHI Summary of this function goes here
%   Detailed explanation goes here

base_location = strcat('train/', directory, '/');

bounding_box = FindAllHands(directory, start, finish);

background = imread('background1.jpg', 'jpg');
background = imcrop(background, bounding_box);

thresholded = cell(1, finish-start);


for i=start:finish,
    s = num2str(i);
    
    if length(s) < 4
        diff = 4 - length(s);
        s = strcat(repmat('0', 1, diff), s);
    end
    
    im_name = strcat('00090.MTS', s);
    im_path = strcat(base_location, im_name, '.jpg');
    
    image = imread(im_path, 'jpg');
    
    
    
    %figure, imshow(imcrop(image, bounding_box))
    current_image = imcrop(image, bounding_box);
    
%     figure, imshow(current_image)
    
    %diff = imabsdiff(current_image, last_image);
    diff = (abs(current_image(:,:,1) - background(:,:,1)) > 20) ...
    | (abs(current_image(:,:,2) - background(:,:,2)) > 20) ...
    | (abs(current_image(:,:,3) - background(:,:,3)) > 20);

    se2 = strel('disk', 5);
    trythis = bwareaopen(diff, 500);
    
%     figure, imshow(trythis)

    dilated = imdilate(trythis, strel('disk', 3));
    %figure, imshow(dilated)
    
    eroded = uint8(imopen(dilated, se2));
    
    %final = eroded/(finish-start);
    
    eroded = eroded * 255;

    %figure, imshow(eroded);
    
    thresholded{i-start+1} = eroded;
end

x = zeros(size(thresholded{1}));
x = thresholded{1};
factor = 1/(finish-start) * 255;


for i=2:finish-start,
    x = imsubtract(x, factor);
    x = imadd(x, thresholded{i});
end

figure, imshow(x);
w = waitforbuttonpress;

%x = cell(1, finish-start);
%x{1} = zeros(bounding_box(3), bounding_box(4));
%for i=2:finish-start,
%    x{i} = abs(thresholded{i}-thresholded{i-1} 
%end

output_args = x;

close all
end