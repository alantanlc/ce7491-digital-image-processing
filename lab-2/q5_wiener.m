clear; clc;

% Read image
G = imread('coins_blurred.tif');
G_fft = fftshift(fft2(G));
[x,y] = size(G);

% Create disk filter of size 2
H = fspecial('disk', 2);
H_fft = fftshift(fft2(H,x,y));

% Apply inverse filter
F_fft = G_fft ./ H_fft;
F = ifft2(fftshift(F_fft));

% Inverse filtering: If we know of or can create a good model of blurring
% function that corrupted an image, the quickest and easiest way to restore
% that is by inverse filtering. Unfortunately, since the inverse filter is
% a form of high pass filter, inverse filtering responds very badly to any
% noise that is present in the image because noise tends to be high
% frequency.

% Show result
r = 2;
c = 3;
subplot(r,c,1);
imshow(G,[]);
subplot(r,c,3);
imshow(F,[]);
subplot(r,c,4);
fftshow(G_fft);
subplot(r,c,5);
fftshow(H_fft);
subplot(r,c,6);
fftshow(F_fft);

function out = wiener(I)
    out = 0
end