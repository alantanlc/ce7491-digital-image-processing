% Edge Detection generally involves:
% 1. EDGE FILTERING - from an input image, generates a grayscale image
% where pixels contain estimates of gradient magnitudes
% 2. EDGEL DETECTION - creates a binary image containing edgels from the
% edge filtered image
% 3. EDGEL LINKING - produces a set of edges consisting of connected edgels

% Clear command window and workspace
clear; clc;

% Read in image
I = rgb2gray(imread('sniper.jpg'));
[I_X, I_Y] = size(I);
imshow(I);

% Mesh
[X,Y]=meshgrid(1:I_Y, 1:I_X);
mesh(X,Y,I);

% Interactive value p and theta
p = 1;
theta = 1;

% Edge filters
gx_prewitt = [-1 -2 -1; 0 0 0; 1 2 1];
gy_prewitt = [-1 0 1; -1 0 1; -1 0 1];
gx_sobel = [-1 -2 -1; 0 0 0; 1 2 1];
gy_sobel = [-1 0 1; -2 0 2; -1 0 1];