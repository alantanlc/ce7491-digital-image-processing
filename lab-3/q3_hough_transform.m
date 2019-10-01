clear; clc;

% Read in image
I = rgb2gray(imread('sniper.jpg'));
[r, c] = size(I);

% Generate symmetrically reflected image
R(r+1:2*r, c+1:2*c) = I;
R(1:r, 1:c) = imrotate(I, 180);
R(1:r, 2*c+1:3*c) = imrotate(I, 180);
R(2*r+1:3*r, 1:c) = imrotate(I, 180);
R(2*r+1:3*r, 2*c+1:3*c) = imrotate(I, 180);
R(1:r, 1*c+1:2*c) = flip(I, 1);
R(2*r+1:3*r, 1*c+1:2*c) = flip(I, 1);
R(1*r+1:2*r, 1:c) = flip(I, 2);
R(1*r+1:2*r, 2*c+1:3*c) = flip(I, 2);

% Apply standard canny edge detection
BW = edge(R, 'canny');
BW = BW(r+1:2*r, c+1:2*c);

% Apply hough transform
[H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89);

% display the original image
subplot(2,1,1);
imshow(I);
title('sniper.jpg');

% Display the hough matrix
subplot(2,1,2);
imshow(imadjust(rescale(H)),'XData',T,'YData',R,'InitialMagnification','fit');
title('Hough transform of sniper.jpg');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,hot);

% Find accumulator bin cell with largest number
[p_max, p_ind] = max(H);
[t_max, t_ind] = max(p_max);
p_index = p_ind(t_ind);
t_index = t_ind;
p = R(p_index);
t = T(t_index);