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

