function [ result ] = RotationInvariant( mhi, cr, cc, u, v )
%ROTATIONINVARIANT Summary of this function goes here
%   Detailed explanation goes here

[width, height] = size(mhi);

result = 0.0;

for x=1:width,
    for y=1:height,
        c1 = complex(x - cr, y - cc);
        c2 = complex(x - cr, cc - y);
        result = result + c1^u * c2^v;
    end
end

end

