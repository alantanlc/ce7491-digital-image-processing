% Clear command window and workspace
clear; clc; clf;

% Read in image and mask
I = imread('flowers.jpg');
J = I;
M = uint8(imread('mask.tif'));

% Extract red and blue from image using mask
M_red = I(:,:,1).*M;
M_blue = I(:,:,3).*M;

% Replace red values with blue values and vice versa
J(:,:,1) = J(:,:,1) - M_red + M_blue;
J(:,:,3) = J(:,:,3) - M_blue + M_red;

% Convert RGB to HSV and extract hue using mask
M = double(M);
HSV = rgb2hsv(I);
M_hue = HSV(:,:,1).*M;

% Rotate M_hue by angles
angles = (0:40:360);
for i=1:length(angles)
    H = mod(M_hue.*360+angles(i),360) / 360;
    H = H.*M;
    K(:,:,:,i) = HSV;
    K(:,:,1,i) = K(:,:,1,i) - M_hue + H;
end

% Part 1 results
figure(1);
subplot(1,2,1);
imshow(I,[]);
subplot(1,2,2);
imshow(J,[]);

% Part 2 results
figure(2);
c = 2;
r = ceil(length(angles)/c);
for i=1:length(angles)
    subplot(r,c,i);
    imshow(hsv2rgb(K(:,:,:,i)));
    title(angles(i));
end