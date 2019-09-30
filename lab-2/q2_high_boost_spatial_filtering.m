% Applying filters that enhance image derivatives will sharpen images

% Laplacian filter enhances edges only. Eliminates slowly varying image
% regions - may not be desirable.

% High boost filtering - mix original image f(x,y) and Laplacian filtered
% image fs(x,y)

% Clear workspace and command window
clc; clear;

% Read in image
I = imread('lena.tif');

% Perform high boost filtering
A = 1;
mask = 1;
J = high_boost_filter(I, mask, A);
imshow([I, J]);

% High-boost filtering function
function J = high_boost_filter(I, M, A)
    % Verify that A is valid
    if A < 1
        error('A must be greater than or equal to 0')
        return
    end

    % Generate mask
    if M == 1   % Mask 1
        mask = double([0 1 0; 1 -4 1; 0 1 0]);
    elseif M == 2   % Mask 2
        mask = double([1 1 1; 1 -8 1; 1 1 1]);
    else
        error('M must be 1 or 2')
        return
    end
    
    % Convert I to double
    f = double(I);
    
    % Compute Laplacian filtered image
    L = zeros(size(I));
    for i=2:size(I,1)-1
       for j = 2:size(I,2)-1
           win = f(i-1:i+1, j-1:j+1);
           L(i,j) = sum(win(:).*mask(:));
       end
    end
    
    % Mix original image and Laplacian filtered image
    J = (A-1).*f + L;
end