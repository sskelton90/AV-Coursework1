function [ bounding_box ] = FindAllHands( directory, start, finish )
%FINDALLHANDS Finds all the bounding boxes in a directory
%   Input: the directory within the train directory e.g. 1-1, the starting
%   image number and the finishing image number. For example, to call this
%   function on the 1-1 directory you would call FindAllHands('1-1', 54,
%   70)
base_location = strcat('train/', directory, '/');

for i=start:finish,
    s = num2str(i);
    
    if length(s) < 4
        diff = 4 - length(s);
        s = strcat(repmat('0', 1, diff), s);
    end
    
    im_name = strcat('00090.MTS', s);
    im_path = strcat(base_location, im_name, '.jpg');
    
    FindHand(im_path, 'background1.jpg')
end