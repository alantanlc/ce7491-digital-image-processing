% Notes:
% Default value of sigma is sqrt(2)

% Clear command window and workspace
clear; clc;

% Read in image
I = rgb2gray(imread('sniper.jpg'));
[x,y] = size(I);

% Generate symmetrically reflected image
R = zeros(x*3,y*3);

% Apply standard Canny edge detection
sigma = sqrt(2);
J = edge(I, 'canny', [], sigma);

imshow(J, []);