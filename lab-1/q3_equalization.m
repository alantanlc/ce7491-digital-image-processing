% Clear workspace and command window
clear; clc;

% Initialize variables
I = imread('Lena.bmp');
local_window_size = 512;

% Perform local histogram equalization
J = localhisteq(I, [local_window_size local_window_size]);
figure(1);
imshow(I);
figure(2);
imshow(J);

% Local histogram equalization function
function J = localhisteq(I, W)

    % Construct reflected image
    % Assumption here is that window size is less than or equals to 512
    reflected_image(513:1024, 513:1024) = I;
    reflected_image(1:512, 1:512) = imrotate(I, 180);
    reflected_image(1:512, 1025:1536) = imrotate(I, 180);
    reflected_image(1025:1536, 1:512) = imrotate(I, 180);
    reflected_image(1025:1536, 1025:1536) = imrotate(I, 180);
    reflected_image(1:512, 513:1024) = flip(I, 1);
    reflected_image(1025:1536, 513:1024) = flip(I, 1);
    reflected_image(513:1024, 1:512) = flip(I, 2);
    reflected_image(513:1024, 1025:1536) = flip(I, 2);
%     imshow(reflected_image);
%     pause;
    
    win_x_half = floor(W(1)/2);
    win_y_half = floor(W(2)/2);
    
    % Compute new pixel value w.r.t local histogram
    for x = size(I,1)+1 : 2*size(I,1)
        for y = size(I,2)+1 : 2*size(I,2)
            % Extract local image
            local_image = reflected_image(x-win_x_half : x+win_x_half, y-win_y_half : y+win_y_half);
            local_image_equalized = histeq(local_image, 255); % MATLAB default histogram size is 64
            
            % Show local image, histogram, equalized image, and equalized histogram
%             figure(1);
%             imshow(local_image);
%             figure(2);
%             imshow(local_image_equalized);
%             figure(3);
%             imhist(local_image);
%             figure(4);
%             imhist(local_image_equalized);

            % Update J with new pixel value
            J(x-size(I,1), y-size(I,2)) = local_image_equalized(win_x_half, win_y_half);
        end
    end
end