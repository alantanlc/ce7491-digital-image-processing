% Clear workspace and command window
clear; clc;

% Read in images
I1 = imread('lena.tif');
I2 = imread('flower.tif');

% Gaussian
I1_gaussian = imnoise(I1, 'gaussian');
I1_gaussian_median = medfilt2(I1_gaussian);
I1_gaussian_gaussian = imgaussfilt(I1_gaussian);

% Salt and pepper
I1_salt = imnoise(I1, 'salt & pepper', 0.02);
I1_salt_median = medfilt2(I1_salt);
I1_salt_gaussian = imgaussfilt(I1_salt);

imshow([I1 I1_gaussian I1_gaussian_median I1_gaussian_gaussian; I1 I1_salt I1_salt_median I1_salt_gaussian]);

% Calculate MSE
err_gaussian_median = immse(I1, I1_gaussian_median);
err_gaussian_gaussian = immse(I1, I1_gaussian_gaussian);
err_salt_median = immse(I1, I1_salt_median);
err_salt_gaussian = immse(I1, I1_salt_gaussian);