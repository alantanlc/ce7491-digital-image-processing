% Clear workspace and command window
clc; clear;

% Read in image
I = imread('flower.tif');

% Perform high boost filtering
A = 1;
mask = 2;
J = high_boost_filter(I, mask, A);
imshow([I, J]);

% High-boost filtering function
function J = high_boost_filter(I, M, A)
    % Verify that A is valid
    A = double(A);
    if A < 1
        disp('A must be greater than or equal to 0')
        return
    end

    % Generate mask
    if M == 1   % Mask 1
        mask = double([1 1 1; 1 -4 1; 1 1 1]);
    elseif M == 2   % Mask 2
        mask = double([1 1 1; 1 -8 1; 1 1 1]);
    else
        'M must be 1 or 2'
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