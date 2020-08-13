picture1 = imread('brain6.jpg');

picture2Bw = im2bw(picture1 , 0.7);

subplot(1,2,1), imshow(picture2Bw);
[label , num] = bwlabel(picture2Bw);

status = regionprops(label , 'Solidity' , 'Area');
density = [status.Solidity];
area = [status.Area];


high_dense_area = density > 0.5;

max_area = max(area(high_dense_area));

tumor_label = find(area == max_area);

tumor = ismember(label , tumor_label);

SE = strel('square' , 5);
tumor = imdilate(tumor , SE);

bound = bwboundaries(tumor , 'noholes');
imshow(picture1);

finalPicture1 = edge(tumor);

[r1 , c1] = find(finalPicture1);

x2 = max(r1);
x1 = min(r1);

y2 = max(c1);
y1 = min(c1);

width = x2 - x1;
heigth = y2 - y1;

if width > 11
    if(heigth > 11)
        subplot(1,2,2) , imshow(tumor);
    end
end
    






















