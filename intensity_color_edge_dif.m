function [ edgeRatio ] = intensity_color_edge_dif(I)
%feature #3
%Returns ratio of intensity edges over intensity + color edges of image
%e.g. edgeRatio = 0 if no color edges, 1 if all edges are color edges, 

I = double(imresize(I,.5)); % to speed up edge detections -- your time is valueable
Gr = rgb2gray(I);

B = Gr == 0;
max(Gr);

Gr = Gr + (1/255)*B; % zero division workaround
Rn = I(:,:,1) ./ Gr;
Gn = I(:,:,2) ./ Gr;
Bn = I(:,:,3) ./ Gr;

Gr_edges = edge(Gr, 'Canny');

Rn_edges = edge(Rn, 'Canny');
Gn_edges = edge(Gn, 'Canny');
Bn_edges = edge(Bn, 'Canny');

Color_edges = Rn_edges | Gn_edges | Bn_edges;

int_edge_count = sum(Gr_edges(:));
col_edge_count = sum(Color_edges(:));

edgeRatio = col_edge_count/(int_edge_count + col_edge_count);
end

