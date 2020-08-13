picture1 = imread('brain4.jpg');

picture2Bw = im2bw(picture1 , 0.7);

figure , imshow(picture1);

[label , num] = bwlabel(picture2Bw);

status = regionprops(label , 'Solidity' , 'Area');
density = [status.Solidity];
area = [status.Area];

high_dense_area = density > 0.5;

disp(high_dense_area);

max_area = max(area(high_dense_area));

tumor_label = find(area == max_area);

tumor = ismember(label , tumor_label);

SE = strel('square' , 5);
tumor = imdilate(tumor , SE);

%bound = bwboundaries(tumor , 'noholes');
imshow(picture1);

%finalPicture1 = edge(tumor);
finalPicture1 = tumor;

[r1 , c1] = find(finalPicture1);

x2 = max(r1);
x1 = min(r1);

y2 = max(c1);
y1 = min(c1);

width = x2 - x1;
heigth = y2 - y1;

if width > 11
    if(heigth > 11)
        figure , imshow(tumor);
    end
end
    






















