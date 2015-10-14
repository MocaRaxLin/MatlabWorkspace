% Author: Justin Lin
% Goal: For assignment 1 part 6d
% Date: Oct. 13 2015

clc      %clear command window
clear  %clear workspace


sence = imread('Scene.bmp');
image_e = imread('letter_e.bmp');
sence = rgb2gray(sence);
image_e = rgb2gray(image_e);

tic;
s = size(sence);
image_e(s(1), s(2)) = 0;
fB = fft2(image_e);
fA = fft2(sence);
cfA = conj(fA); 
v = ifft2(cfA.*fB);

toc;

plot(v);
figure;
h = surf(v);
set(h,'LineStyle','none');