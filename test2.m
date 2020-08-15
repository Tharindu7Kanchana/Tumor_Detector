brain = imread('brain1.jpg');

brainGrey = (brain);

brainFilter1 = medfilt2(brainGrey);
brainFilter2 = medfilt2(brainFilter1);
brainFilter3 = medfilt2(brainFilter2);
brainFilter4 = medfilt2(brainFilter3);
brainFilter5 = medfilt2(brainFilter4);

figure , imshow(brainFilter5),title('Filtered Image');


brainEdges = edge(brainFilter5 , 'sobel');

brainBW = im2bw(brainFilter5 , 0.7);
brainBW = bwmorph(brainBW,'open');
figure , imshow(brainBW),title('Binary image');
figure , imshow(brainEdges),title('Brain Edges');

se = strel('disk',5);
afterOpening = imopen(brainFilter5,se);
figure, imshow(afterOpening,[]),title('image open erosion followed by dialation');
brainEdges = edge(afterOpening , 'sobel');

brainBW = im2bw(afterOpening , 0.7);
brainBW = bwmorph(brainBW,'open');
figure , imshow(brainBW),title('Binary image');
figure , imshow(brainEdges),title('Brain Edges');

[centers, radii] = imfindcircles(afterOpening,[10 30],'ObjectPolarity','bright','Sensitivity',0.8);
figure
imshow(im)
viscircles(centers,radii);


threshold = graythresh(afterOpening);
brainBW = im2bw(afterOpening,threshold);
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(brainBW), hy, 'replicate');
Ix = imfilter(double(brainBW), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
figure
imshow(gradmag,[]), title('Gradient magnitude (gradmag)');
ws = watershed(gradmag);
figure
imshow(ws),title('Watershed Transformation','color','b')
added = imadd(brainEdges,im2bw(gradmag));
imshow(added)