function [ result ] = ScaleInvariant( tim, area, u, v )
%SCALEINVARIANT Summary of this function goes here
%   tim - Translation Invariant Moment for the same u and v
%   area - Area of the MHI

result = tim / area^(double(u+v)/2.0 + 1);

end

