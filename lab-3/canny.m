clear; clc;

% Step 0: Select input image
I = imread('sniper.jpg');

% Step 1: Convert image to grayscale
G = rgb2gray(I);

% Step 2: Noise removal using gaussian filter
gaussian = [1/16 2/16 1/16; 2/16 4/16 2/16; 1/16 2/16 1/16];
G_gaussian = conv2(G, gaussian);

% subplot(1,2,1);
% imshow(G);
% subplot(1,2,2);
% imshow(G_gaussian, []);

% Step 3: Sobel filter (basic edge detection)
sobelx = [-1 0 1; -2 0 2; -1 0 1];
sobely = [-1 -2 -1; 0 0 0; 1 2 1];
Gx = conv2(G_gaussian, sobelx);
Gy = conv2(G_gaussian, sobely);

subplot(1,2,1);
imshow(abs(Gx), []);
subplot(1,2,2);
imshow(abs(Gy), []);
linkaxes;

Dir = atan(Gy/Gx);
Mag = sqrt(Gy.*Gy+Gx.*Gx);

