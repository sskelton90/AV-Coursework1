function [ output_args ] = ComputeDescriptor( directory, start, finish )
%COMPUTEDESCRIPTOR Summary of this function goes here
%   Detailed explanation goes here

mhi = ComputeMHI(directory, start, finish);

[width, height] = size(mhi);
area = 0;
cr = 0.0; % center of mass
cc = 0.0;

%variables used for calculating center of mass
tr = 0.0;
tc = 0.0;

%calculate area of mhi and center of mass
for x=1:width,
    for y=1:height,
        if (mhi(x,y) > 0)
            area = area + 1;
        end
        
        tr = tr + x * (double(mhi(x, y)) / 255.0);
        tc = tc + y * (double(mhi(x, y)) / 255.0);
    end
end

cr = tr / double(area);
cc = tc / double(area);

%Calculate translation invariant moment
tim = TranslationInvariant(mhi, cr, cc, 1, 1) %translation invariant moment for u=1, v=1

end

