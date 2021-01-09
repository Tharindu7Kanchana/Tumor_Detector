im = imread('brain21.jpg');
i=imfinfo('brain5.jpg');
if strcmp(i.ColorType,'truecolor')
    im=rgb2gray(im);
end
subplot(2, 3, 1);
imshow(im, []);
axis on;
caption = sprintf('Original Image');
title(caption, 'FontSize', 18, 'Interpreter', 'None');
drawnow;
subplot(2,3,5)
im=medfilt2(im);
imshow(im);
subplot(2,3,6)
im=adapthisteq(im);
imshow(im);
threshold = graythresh(im);
brain=im2bw(im,threshold);
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(brain), hy, 'replicate');
Ix = imfilter(double(brain), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
subplot(2,3,2)
imshow(gradmag,[]), title('Gradient magnitude (gradmag)');

% remove all object containing fewer than 30 pixels
bw = bwareaopen(gradmag,40);
% fill any holes, so that regionprops can be used to estimate
% the area enclosed by each of the boundaries
bw = imfill(bw,'holes');
subplot(2,3,3)
imshow(bw)

subplot(2,3,4)
filled=imfill(gradmag,'holes');
imshow(filled)
%==========================================================================================
brain = imread('brain1.jpg');

brainGrey = (brain);


brainFilter1 = medfilt2(brainGrey);
brainFilter2 = medfilt2(brainFilter1);
brainFilter3 = medfilt2(brainFilter2);
brainFilter4 = medfilt2(brainFilter3);
brainFilter5 = medfilt2(brainFilter4);
brainFilter5 = bwmorph(brainFilter5,'open');
figure , imshow(brainFilter5),title('Filtered Image');


brainEdges = edge(brainFilter5 , 'sobel');


brainBW = im2bw(brainFilter5 , 0.7);

figure , imshow(brainBW),title('Binary image');
figure , imshow(brainEdges),title('Brain Edges');
im = brainFilter5;
figure
threshold = graythresh(im);
brain=brainBW;
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(brain), hy, 'replicate');
Ix = imfilter(double(brain), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
subplot(2,3,2)
imshow(gradmag,[]), title('Gradient magnitude (gradmag)');

% remove all object containing fewer than 30 pixels
bw = bwareaopen(gradmag,40);
% fill any holes, so that regionprops can be used to estimate
% the area enclosed by each of the boundaries
bw = imfill(bw,'holes');
subplot(2,3,3)
imshow(bw)     
erodedBW = bw;
subplot(1,3,3), imshow(erodedBW)
[centers, radii] = imfindcircles(erodedBW,[5 15],'ObjectPolarity','bright','Sensitivity',1);
figure
imshow(im)
h = viscircles(centers,radii);
