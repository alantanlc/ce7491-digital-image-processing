% Hue value ranges from 0 - 1
% Multiply hue value by 360 to convert to degrees and rotate by adding/subtracting
% angle in degrees, modulus by 360
% Multiply hue value by 2pi to convert to radians and rotate by adding/subtracting
% angle in radians, modulus by 2pi
% Remember to scale hue value range back to 0 and 1

% Clear command window and workspace
clear; clc; clf;

% Read in image and mask
I = imread('flowers.jpg');
J = I;
M = uint8(imread('mask.tif'));

% Part 1: Extract red and blue from image using mask
M_red = I(:,:,1).*M;
M_blue = I(:,:,3).*M;

% Part 1: Replace red values with blue values and vice versa
J(:,:,1) = J(:,:,1) - M_red + M_blue;
J(:,:,3) = J(:,:,3) - M_blue + M_red;

% Part 2: Convert RGB to HSV and extract hue using mask
M = double(M);
HSV = rgb2hsv(I);
M_hue = HSV(:,:,1).*M;

% Part 2: Rotate M_hue by angles
angles = (0:40:360);
for i=1:length(angles)
    H = mod(M_hue.*360+angles(i),360) / 360;
    H = H.*M;
    K(:,:,:,i) = HSV;
    K(:,:,1,i) = K(:,:,1,i) - M_hue + H;
end

% Part 1 Results
figure(1);
subplot(1,2,1);
imshow(I,[]);
subplot(1,2,2);
imshow(J,[]);
linkaxes;

% Part 2 Results
figure(2);
c = 4;
r = ceil(length(angles)/c);
for i=1:length(angles)
    subplot(r,c,i);
    imshow(hsv2rgb(K(:,:,:,i)));
    title(angles(i));
end