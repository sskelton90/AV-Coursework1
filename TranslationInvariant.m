function [ result ] = TranslationInvariant( mhi, cr, cc, u, v )
%TRANSLATIONINVARIANT Summary of this function goes here
%   Input:
%   mhi - MHI image array from ComputeMHI
%   cr - center of mass, row value
%   cc - center of mass, column value

[width, height] = size(mhi);

result = 0.0;

for x=1:width,
    for y=1:height,
        result = result + ((double(x) - cr)^u) * ((double(y) - cc)^v) * double(mhi(x, y) / 255.0);
    end
end

end

