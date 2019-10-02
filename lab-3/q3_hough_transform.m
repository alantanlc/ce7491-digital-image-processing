% Clear command window and workspace
clear; clc;

% The Hough transform matrix, H, is NRHO-by-NTHETA
% NRHO = (2*ceil*D/RhoResolution)) + 1 where
% D = sqrt((numRowsInBW - 1)^2 + (numColsInBW - 1)^2)
%   In our case:
%       RhoResolution = 0.5 (interactive input by user)
%       D = sqrt((634-1)^2 + (845-1)^2) = 1055

% RhoResolution is a real scalar between 0 and norm(size(BW)), exclusive.
% RhoResolution specifies the spacing of the Hough transform bins along the
% rho axis. Default: 1.
   
% RHO values range from -DIAGONAL to DIAGONAL where
% DIAGONAL = RhoResolution*ceil(D/RhoResolution)
%   In our case,
%   For RhoResolution = 0.5
%   DIAGONAL = 0.5*ceil(1055/0.5) = 1055

% THETA values are within the range [-90,90) degrees with variable step
% size (interactive input by user)

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
RhoResolution = 1;
ThetaStepSize = 1;
[H,T,R] = hough(BW,'RhoResolution',RhoResolution,'Theta',-90:ThetaStepSize:89);

% Find accumulator bin cell with largest number
[p_max, p_ind] = max(H);
[t_max, t_ind] = max(p_max);
p_index = p_ind(t_ind);
t_index = t_ind;
p = R(p_index);
t = T(t_index);

% Find most prominent edge
x1 = p / cosd(t); % when y = 0
y1 = 0;
x2 = 0;
y2 = p / sind(t); % when x = 0

% Display the original image and most prominent line
subplot(2,1,1);
imshow(I);
line([x1,x2],[y1,y2]);
title('sniper.jpg');

% Display the hough matrix
subplot(2,1,2);
imshow(imadjust(rescale(H)),'XData',T,'YData',R,'InitialMagnification','fit');
title('Hough transform of sniper.jpg');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,hot);