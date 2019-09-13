clear; clc;

I = imread('flowers.jpg');
J = I;
M = uint8(imread('mask.tif'));

M_red = I(:,:,1).*M;
M_blue = I(:,:,3).*M;

J(:,:,1) = J(:,:,1) - M_red + M_blue;
J(:,:,3) = J(:,:,3) - M_blue + M_red;

subplot(1,2,1);
imshow(I,[]);
subplot(1,2,2);
imshow(J,[]);