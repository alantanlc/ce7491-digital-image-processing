% Clear workspace and command window
clc; clear;

% Read in image
I = imread('flower.tif');

% Perform high boost filtering
J = high_boost_filter(I, 2, 1);
imshow([I, J]);

% High-boost filtering function
function J = high_boost_filter(I, M, A)
    J = I;
    
    % Verify that A is valid
    A = double(A);
    if A < 1
        disp('A must be greater than or equal to 0')
        return
    end

    % Generate mask
    if M == 1   % Mask 1
        mask = double([0 -1 0; -1 A+4 -1; 0 -1 0]);
        mask
    elseif M == 2   % Mask 2
        mask = double([-1 -1 -1; -1 A+8 -1; -1 -1 -1]);
        mask
    else
        'M must be 1 or 2'
    end
    
    % Convert I to double
    f = double(I);
    
    % Perform convolution
    for i=2:size(I,1)-1
       for j = 2:size(I,2)-1
           win = f(i-1:i+1, j-1:j+1);
           J(i,j) = sum(win(:).*mask(:));
       end
    end
end