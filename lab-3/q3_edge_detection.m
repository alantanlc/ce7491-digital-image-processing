% Notes:
% Default value of sigma is sqrt(2)
% Threshold must be less than 1

% Clear command window and workspace
clear; clc;

% Read in image
I = rgb2gray(imread('sniper.jpg'));
[r, c] = size(I);

% Generate symmetrically reflected image
R(r+1:2*r, c+1:2*c) = I;
R(1:r, 1:c) = imrotate(I, 180);
R(1:r, 2*c+1:3*c) = imrotate(I, 180);
R(2*r+1:3*r, 1:c) = imrotate(I, 180);
R(2*r+1:3*r, 2*c+1:3*c) = imrotate(I, 180);
R(1:r, 1*c+1:2*c) = flip(I, 1);
R(2*r+1:3*r, 1*c+1:2*c) = flip(I, 1);
R(1*r+1:2*r, 1:c) = flip(I, 2);
R(1*r+1:2*r, 2*c+1:3*c) = flip(I, 2);

% Apply standard Canny edge detection
sigma = sqrt(2);
J = edge(R, 'canny', [], sigma);
J = J(r+1:2*r, c+1:2*c);

% Show result
subplot(1,2,1);
imshow(edge(I, 'canny', [], sigma));
subplot(1,2,2);
imshow(J, []);
linkaxes;