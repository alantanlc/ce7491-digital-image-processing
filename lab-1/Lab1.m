% Clear workspace and command window
clear; clc;

% Initialie variables
files = ["Lena.bmp", "Peppers.bmp", "Mandrill.bmp"];
quant_levels = [2 4 6 8 16 64];

% Loop through images
for i = 1 : length(files)
    image = imread(files(i));

    % Loop through quantization level
    for j = 1 : length(quant_levels)
        ['Quantization level: ', num2str(quant_levels(j))]

        % Compute and show quantized image
        figure(1);
        imshow(image / quant_levels(j), []);
        
        figure(2);
        imhist(image / quant_levels(j));
        
        % Pause
        pause;
    end
end