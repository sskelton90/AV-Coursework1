function [ bounding_box ] = FindAllHands( directory, start, finish )
%FINDALLHANDS Finds all the bounding boxes in a directory
%   Input: the directory within the train directory e.g. 1-1, the starting
%   image number and the finishing image number. For example, to call this
%   function on the 1-1 directory you would call FindAllHands('1-1', 54,
%   70)
%   Output: The bounding box that bounds all the bounding boxes found from
%   each of the images.

directory
base_location = strcat('train/', directory, '/');

leftmost = 10000;
rightmost = 0;
topmost = 10000;
bottommost = 0;

current = [leftmost, topmost, rightmost - leftmost, bottommost - topmost];

for i=start+3:finish,
    s = num2str(i);
    
    if length(s) < 4
        diff = 4 - length(s);
        s = strcat(repmat('0', 1, diff), s);
    end
    
    im_name = strcat('00090.MTS', s);
    im_path = strcat(base_location, im_name, '.jpg');
    
    bounding_box = FindHand(im_path, 'background1.jpg');
    %|| (rectint(bounding_box, current) == 0 && ~(i == start))
    
    if bounding_box(3) == 0 || bounding_box(4) == 0 || ~RectIntersect(bounding_box, current)
        continue
    end
    
    ul_x = bounding_box(1);
    ul_y = bounding_box(2);
    btr_x = ul_x + bounding_box(3);
    btr_y = ul_y + bounding_box(4);
    
    if ul_x < leftmost
        leftmost = ul_x;
    end
    
    if ul_y < topmost
        topmost = ul_y;
    end
    
    if btr_x > rightmost
        rightmost = btr_x;
    end
    
    if btr_y > bottommost
        bottommost = btr_y;
    end
    
    current = [leftmost, topmost, rightmost - leftmost, bottommost - topmost];
    rectangle('Position', current,'EdgeColor','r');
end

close all
bounding_box = [leftmost, topmost, rightmost - leftmost, bottommost - topmost]

