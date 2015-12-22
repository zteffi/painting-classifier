function [ saturation_count ] = high_saturation_px_count(RGB)
%feature #1
%high_saturation_px_count
%returns number of pixels in RGB image, whos saturation exceeds 75%
%threshold
%RGB is rgb image in double precision

HSV = rgb2hsv(RGB);
S = HSV(:,:,2);
B = (S >= .75);
saturation_count = sum(B(:))/size(S(:),1);
end

