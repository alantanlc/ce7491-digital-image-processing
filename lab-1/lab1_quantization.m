% Clear workspace and command window
clear; clc;

% Initialie variables
files = ["Lena.bmp", "Peppers.bmp", "Mandrill.bmp"];
quant_levels = [2 4 6 8 16 64];

% Loop through images
for i = 1 : length(files)
    image = imread(files(i));

    % Quantization
    for j = 1 : length(quant_levels)
        ['Quantization level: ', num2str(quant_levels(j))]

        % Compute quantized image
        quantized_image = image / quant_levels(j);
        
        % Show quantized image
        figure(1);
        imshow(quantized_image, []);
        
        % Show histogram
        figure(2);
        imhist(quantized_image);
        
        % Pause
        pause;
    end
end