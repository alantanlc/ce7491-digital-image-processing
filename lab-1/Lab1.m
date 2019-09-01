% Clear workspace and command window
clear; clc;

% Read in images
img_lena = imread('Lena.bmp');
img_peppers = imread('Peppers.bmp');
img_mandrill = imread('Mandrill.bmp');

images = [img_lena img_peppers img_mandrill];

% Loop through each quantization level and show quantized images as figures
quant_levels = [2 4 6 8 16 64];
for i = 1 : length(quant_levels)
    quant_levels(i)
    
    % Divide images by quantization level
    quantized_img = images / quant_levels(i);
    
    % Show image
    imshow(quantized_img, []);
    
    % Pause
    pause;
end