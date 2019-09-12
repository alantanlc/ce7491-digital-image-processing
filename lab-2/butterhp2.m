function out = butterhp2(im,d,n)
    h = size(im,1);
    w = size(im,2);
    [x,y] = meshgrid(-floor(w/2):floor(w-1)/2, -floor(h/2):floor(h-1)/2);
    out = 1./(1+(d^2./(x.^2+y.^2)).^n);
end