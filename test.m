brain = imread('brain1.jpg');

brainGrey = (brain);


brainFilter1 = medfilt2(brainGrey);
brainFilter2 = medfilt2(brainFilter1);
brainFilter3 = medfilt2(brainFilter2);
brainFilter4 = medfilt2(brainFilter3);
brainFilter5 = medfilt2(brainFilter4);

figure , imshow(brainFilter5);


brainEdges = edge(brainFilter5 , 'sobel');


brainBW = im2bw(brainFilter5 , 0.7);
figure , imshow(brainBW);
figure , imshow(brainEdges);
