% Clear workspace and command window
clear; clc;

% Read in images
I1 = imread('pout.tif');
I2 = imread('bright_flower.tif');

% Perform histogram transfer
NewImage = histTransfer(I1, I2);

% Histogram transfer function
function NewImage = histTransfer(I1, I2)
    imshow(I2)
    
    NewImage = 0;
end