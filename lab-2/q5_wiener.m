clear; clc;

% Read image
G = imread('coins_blurred.tif');
G_fft = fftshift(fft2(G));
[x,y] = size(G);

% Create disk filter of size 2
H = fspecial('disk', 2);
H_fft = fftshift(fft2(H,x,y));

% Apply inverse filtering
I_fft = G_fft ./ H_fft;
I = ifft2(fftshift(I_fft));

% Apply wiener filtering
K = 0.0025;
W_fft = conj(H_fft) ./ ((abs(H_fft)).^2 + K);
F_fft = G_fft .* W_fft;
F = ifft2(fftshift(F_fft));
F(F < 0) = 0;
F(F > 255) = 255;

% Show result
r = 2;
c = 4;

% Degraded
subplot(r,c,1);
imshow(G);
subplot(r,c,5);
fftshow(G_fft);

% Disk filter with radius 2
subplot(r,c,6);
fftshow(H_fft);

% Inverse filtering
subplot(r,c,3);
imshow(I,[]);
subplot(r,c,7);
fftshow(I_fft);

% Wiener filtering
subplot(r,c,4);
imshow(F,[]);
subplot(r,c,8);
fftshow(F_fft);

% Inverse filtering: If we know of or can create a good model of blurring
% function that corrupted an image, the quickest and easiest way to restore
% that is by inverse filtering. Unfortunately, since the inverse filter is
% a form of high pass filter, inverse filtering responds very badly to any
% noise that is present in the image because noise tends to be high
% frequency.

% Wiener filtering: The basic idea of Wiener filtering is that we want to
% minimize the mean square error between the reconstruction and the
% original signal.