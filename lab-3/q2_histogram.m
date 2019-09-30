% Observations

% After RGB equalization, there's a more uniform distribution of the
% individual RGB channels
    % Flower petals become less red
    % Leaves become less green, starting to turn yellow due to drop in
    % green and blue levels
    % Since more RGB is distributed to higher levels as compared to
    % original, there is an increase in brighter color levels such as
    % white, resulting in a brighter image

% After V equalization, red and green is slightly more distributed to
% brighter levels, not so much for blue
    % Little effect on blue histogram
    % Could it be because image is large red (flower) and green (leaves);

% Clear command window and workspace
clear; clc;

% Read in image
I = imread('flowers.jpg');
I_HSV = rgb2hsv(I);
I_LAB = rgb2lab(I);

% Part 1: Equalize the 3 RGB channels individually and combine the results
RGB_1(:,:,1) = histeq(I(:,:,1));
RGB_1(:,:,2) = histeq(I(:,:,2));
RGB_1(:,:,3) = histeq(I(:,:,3));
HSV_1 = rgb2hsv(RGB_1);
LAB_1 = rgb2lab(RGB_1);

% Part 2: Convert to HSV and equalize only V, convert back to RGB
HSV_2 = rgb2hsv(I);
HSV_2(:,:,3) = histeq(HSV_2(:,:,3));
RGB_2 = hsv2rgb(HSV_2);
LAB_2 = rgb2lab(RGB_2);

% Part 3: Convert to L*a*b and equalize only L*, convert back to RGB
LAB_3 = rgb2lab(I);
LAB_3(:,:,1) = histeq(LAB_3(:,:,1));
RGB_3 = lab2rgb(LAB_3);
HSV_3 = rgb2hsv(RGB_3);

% Results
r = 2;
c = 2;
subplot(r,c,1);
imshow(I);
title('Original');
subplot(r,c,2);
imshow(RGB_1);
title('(i)');
subplot(r,c,3);
imshow(RGB_2);
title('(ii)');
subplot(r,c,4);
imshow(RGB_3);
title('(iii)');

% RGB Histogram
figure; r = 4; c = 3;
subplot(r,c,1); imhist(I(:,:,1)); title('Original R');
subplot(r,c,2); imhist(I(:,:,2)); title('Original G');
subplot(r,c,3); imhist(I(:,:,3)); title('Original B');
subplot(r,c,4); imhist(RGB_1(:,:,1)); title('RGB R');
subplot(r,c,5); imhist(RGB_1(:,:,2)); title('RGB G');
subplot(r,c,6); imhist(RGB_1(:,:,3)); title('RGB B');
subplot(r,c,7); imhist(RGB_2(:,:,1)); title('HSV R');
subplot(r,c,8); imhist(RGB_2(:,:,2)); title('HSV G');
subplot(r,c,9); imhist(RGB_2(:,:,3)); title('HSV B');
subplot(r,c,10); imhist(RGB_3(:,:,1)); title('LAB R');
subplot(r,c,11); imhist(RGB_3(:,:,2)); title('LAB G');
subplot(r,c,12); imhist(RGB_3(:,:,3)); title('LAB B');

% HSV Histogram
figure; r = 4; c = 3;
subplot(r,c,1); imhist(I_HSV(:,:,1)); title('Original H');
subplot(r,c,2); imhist(I_HSV(:,:,2)); title('Original S');
subplot(r,c,3); imhist(I_HSV(:,:,3)); title('Original V');
subplot(r,c,4); imhist(HSV_1(:,:,1)); title('RGB H');
subplot(r,c,5); imhist(HSV_1(:,:,2)); title('RGB S');
subplot(r,c,6); imhist(HSV_1(:,:,3)); title('RGB V');
subplot(r,c,7); imhist(HSV_2(:,:,1)); title('HSV H');
subplot(r,c,8); imhist(HSV_2(:,:,2)); title('HSV S');
subplot(r,c,9); imhist(HSV_2(:,:,3)); title('HSV V');
subplot(r,c,10); imhist(HSV_3(:,:,1)); title('LAB H');
subplot(r,c,11); imhist(HSV_3(:,:,2)); title('LAB S');
subplot(r,c,12); imhist(HSV_3(:,:,3)); title('LAB V');

% LAB Histogram
figure; r = 4; c = 3;
subplot(r,c,1); imhist(I_LAB(:,:,1)); title('Original L');
subplot(r,c,2); imhist(I_LAB(:,:,2)); title('Original A');
subplot(r,c,3); imhist(I_LAB(:,:,3)); title('Original B');
subplot(r,c,4); imhist(LAB_1(:,:,1)); title('RGB L');
subplot(r,c,5); imhist(LAB_1(:,:,2)); title('RGB A');
subplot(r,c,6); imhist(LAB_1(:,:,3)); title('RGB B');
subplot(r,c,7); imhist(LAB_2(:,:,1)); title('HSV L');
subplot(r,c,8); imhist(LAB_2(:,:,2)); title('HSV A');
subplot(r,c,9); imhist(LAB_2(:,:,3)); title('HSV B');
subplot(r,c,10); imhist(LAB_3(:,:,1)); title('LAB L');
subplot(r,c,11); imhist(LAB_3(:,:,2)); title('LAB A');
subplot(r,c,12); imhist(LAB_3(:,:,3)); title('LAB B');