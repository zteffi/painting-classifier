function [uniqueColors] = unique_color_count(RGB)
%feature #2
%returns ratio of unique colors in image
[IND, map] = rgb2ind(RGB, 255*255);
uniqueColors = size(map,1)/size(IND(:),1);
end

