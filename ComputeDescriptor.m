function [ feature_vector ] = ComputeDescriptor( directory, start, finish )
%COMPUTEDESCRIPTOR Summary of this function goes here
%   Detailed explanation goes here

mhi = ComputeMHI(directory, start, finish);

[width, height] = size(mhi);
area = 0.0;
cr = 0.0; % center of mass
cc = 0.0;

%variables used for calculating center of mass
tr = 0.0;
tc = 0.0;

%calculate area of mhi and center of mass
for x=1:width,
    for y=1:height,
        area = area + double(mhi(x, y)) / 255.0;
        
        tr = tr + x * (double(mhi(x, y)) / 255.0);
        tc = tc + y * (double(mhi(x, y)) / 255.0);
    end
end

cr = tr / double(area);
cc = tc / double(area);

%Calculate translation invariant moment
tim11 = TranslationInvariant(mhi, cr, cc, 1, 1); %translation invariant moment for u=1, v=1
tim22 = TranslationInvariant(mhi, cr, cc, 2, 2);

%Calculate scale invariant moment
sim11 = ScaleInvariant(tim11, area, 1, 1);
sim22 = ScaleInvariant(tim22, area, 2, 2);

%Calculate rotation invariant moments
c11 = RotationInvariant(mhi, cr, cc, 1, 1);
c20 = RotationInvariant(mhi, cr, cc, 2, 0);
c21 = RotationInvariant(mhi, cr, cc, 2, 1);
c12 = RotationInvariant(mhi, cr, cc, 1, 2);
c30 = RotationInvariant(mhi, cr, cc, 3, 0);

%Scale rotation invariant moments
s11 = c11 / (area^2);
s20 = c20 / (area^2);
s21 = c21 / (area^2.5);
s12 = c12 / (area^2.5);
s30 = c30 / (area^2.5);

%Rescaled rotation invariant moments
ci1 = real(s11);
ci2 = real(1000 * s21 * s12);
ci3 = 10000 * real(s20 * s12 * s12);
ci4 = 10000 * imag(s20 * s12 * s12);
ci5 = 1000000 * real(s30 * s12 * s12 * s12);
ci6 = 1000000 * imag(s30 * s12 * s12 * s12);


% bwperim supposedly only works on binary images, but it still gives an
% answer here
% bwarea seems to give a similar (but not exact) answer to the custom area
% function above, so maybe it works
perim = bwarea(bwperim(mhi,4));
compactness = perim*perim / (4*pi*area);

feature_vector = [ci2, ci4, sim11, ci6];
%feature_vector = [sim11, ci4];
%feature_vector = [ci1, sim20, sim11];
%feature_vector = [compactness, ci1];
%feature_vector = [compactness, ci1, ci2, ci3, ci4, ci5, ci6];

% % % 
% m1 = mean(feature_vector);
% m2 = max(feature_vector);
% % % 
% feature_vector = feature_vector - m1;
% feature_vector = feature_vector / m2;

end

