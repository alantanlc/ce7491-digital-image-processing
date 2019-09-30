clear; clc;

% Initialize variables
d0 = 50;
n = 2;
ftype = 'high'; % low or high
rows = 2;
cols = 4;

% Read in image
I = imread('lena.tif');
subplot(rows,cols,1);
imshow(I);

% Apply butterworth filter
J = butterworth(I, d0, n, ftype);

function J = butterworth(I, d0, n, ftype)
    rows = 2;
    cols = 4;
    
    % Convert I to frequency domain
    [nx ny] = size(I);
    fftI = fftshift(fft2(I, 2*nx-1, 2*ny-1));
    subplot(rows,cols,5);
    fftshow(fftI);

    % Construct butterworth filter H
    [X, Y] = meshgrid(-nx+1:ny-1);
    if strcmp(ftype, 'high') % high pass filter
        H = 1./(1+(d0^2./(X.^2+Y.^2)).^n);
    else % low pass filter
        H = 1./(1.+((X.^2+Y.^2)/d0^2).^n);
    end
    subplot(rows,cols,6);
    fftshow(H);

    % Plot Butterworth filter H
    subplot(rows,cols,2);
    mesh(X, Y, H);

    % Apply filter H to fftI
    J = fftI.*H;
    subplot(rows,cols,7);
    fftshow(J);
    J = ifftshift(J);
    J = ifft2(J, 2*nx-1, 2*ny-1);
    J = uint8(real(J(1:nx,1:ny)));
    subplot(rows,cols,3);
    imshow(J);

    % Apply filter H to fftI plus original image
    A = 0.5;
    B = 0.5;
    J = A.*(fftI) + B.*(fftI.*H);
%     J = fftI.*H;
    
    subplot(rows,cols,8);
    fftshow(J);
    J = ifftshift(J);
    J = ifft2(J, 2*nx-1, 2*ny-1);
    J = uint8(real(J(1:nx,1:ny)));
    subplot(rows,cols,4);
    imshow(J);
end