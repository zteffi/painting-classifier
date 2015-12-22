function [ thresh ] = getThreshold(paint, photo)
%returns threshold of 2 vectors (linear interpolation with respect to
%sigmas)
%a1,a2 = [avg, sigma]

if (paint(1) > photo(1))
    pmax = paint;
    pmin =  photo;
else 
    pmax = photo;
    pmin = paint;
end
k = (pmax(1) - pmin(1))/( pmax(2) + pmin(2));
thresh = pmin(1) + k*pmin(2);
end

