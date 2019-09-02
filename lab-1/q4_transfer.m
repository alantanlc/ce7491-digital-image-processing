% Clear workspace and command window
clear; clc;

% Read in images
I1 = imread('pout.tif');
I2 = imread('bright_flower.tif');

% Perform histogram transfer
NewImage = histTransfer(I1, I2);

% Histogram transfer function
function NewImage = histTransfer(I1, I2)
    % Compute histogram of I1
    I1_hist = imhist(I1);
    
    % Equalize I2 using I1's histrogram
    NewImage = histeq(I2, I1_hist);
    
    figure(1);
    imshow(I1);
    figure(2);
    imhist(I1);
    
    figure(3);
    imshow(I2);
    figure(4);
    imhist(I2);
    
    figure(5);
    imshow(NewImage);
    figure(6);
    imhist(NewImage);
end