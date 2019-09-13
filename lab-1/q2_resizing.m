% Clear workspace and command window
clear; clc;

% Initialize variables
files = ["Lena.bmp", "Peppers.bmp", "Mandrill.bmp"];
resize_levels = [2 4 8 16];

% Loop through images
for i = 1 : length(files) 
   image = imread(files(i));
   
   % Resizing
   for j = 1 : length(resize_levels)
      ['Resize level: ', num2str(resize_levels(j))]
      
      % Compute resized image
      resized_image = imresize(image, 1/resize_levels(j));
      
      % Show resized image
      figure(1);
      imshow(resized_image, []);
      
      % Show histogram
      figure(2);
      imhist(resized_image);
      
      % Pause
      pause;
   end
end