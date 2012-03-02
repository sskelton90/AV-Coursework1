function [ result ] = RectIntersect( rect1, rect2 )
%RECTINTERSECT Summary of this function goes here
%   Detailed explanation goes here

    result = 0;

    if (rectint(rect1,rect2) ~= 0)
        result = 1;
        return
    end
    
    if rect1(3) * rect1(4) > rect2(3) * rect2(4)
       temp = rect1;
       rect1 = rect2;
       rect2 = temp;
    end
    
    rect1_pos = [rect1(1), rect1(2), rect1(1) + rect1(3), rect1(2) + rect1(4)];
    rect2_pos = [rect2(1), rect2(2), rect2(1) + rect2(3), rect2(2) + rect2(4)];
    
    if (rect1_pos(1) <= rect2_pos(1) && rect1_pos(2) <= rect2_pos(2) && ...
             rect1_pos(3) >= rect2_pos(3) && rect1_pos(3) >= rect2_pos(3))
       result = 1;
       return
    end
end

