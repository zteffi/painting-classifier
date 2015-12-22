function [vals] = getTrainData()
%load values for images in folder
folder_name = uigetdir;
folder_name  = strcat(folder_name, '\');
path =strcat(folder_name,'*.jpg');
images = dir(path);
fprintf('Loading %5d images... \n', length(images)); 
Image = zeros(length(images),740,740,3);
for i = 1:length(images)
   I = imread(strcat(folder_name,images(i).name));
   Image(i,:,:,:) = im2double(I);
end

ImgSize = size(Image,1);
vals = zeros(3,2);

avgImg = 0;
valsImg = (1:ImgSize);
fprintf('Calculating Saturation... \n'); 

for i = 1:ImgSize
    hsc = high_saturation_px_count(squeeze(Image(i,:,:,:)));
    avgImg = avgImg + hsc;
    valsImg(i) = hsc;
end

avgImg = avgImg/ImgSize;
sigmaImg = sum(abs(valsImg - avgImg))/ImgSize;


vals(1,:) = [avgImg, sigmaImg];

avgImg = 0;
fprintf('Calculating Unique Colors... \n'); 
for i = 1:ImgSize
    ucc = unique_color_count(squeeze(Image(i,:,:,:)));
    valsImg(i) = ucc;
    avgImg = avgImg + ucc;
end
avgImg = avgImg/ImgSize;
sigmaImg = sum(abs(valsImg - avgImg))/ImgSize;
vals(2,:) = [avgImg, sigmaImg];


avgImg = 0;
fprintf('Calculating Edges... \n'); 
for i = 1:ImgSize
    iced = intensity_color_edge_dif(squeeze(Image(i,:,:,:)));
    valsImg(i) = iced;
    avgImg = avgImg + iced;
end

avgImg = avgImg/ImgSize;
sigmaImg = sum(abs(valsImg - avgImg))/ImgSize;
vals(3,:) = [avgImg, sigmaImg];
fprintf('Done!\n'); 


