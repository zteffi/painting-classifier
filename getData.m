function [ vals ] = getData(I)
%Returns feature values for I
vals = [0 0 0];
vals(1) =  high_saturation_px_count(I);
vals(2) =  unique_color_count(I);
vals(3) = intensity_color_edge_dif(I);
end

