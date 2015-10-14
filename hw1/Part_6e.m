% Author: Justin Lin
% Goal: For assignment 1 part 6e
% Date: Oct. 13 2015

clc      %clear command window
clear  %clear workspace


sence = imread('Scene.bmp');
image_o = imread('letter_o.bmp');
sence = rgb2gray(sence);
image_o = rgb2gray(image_o);

tic;

s = size(sence);
image_o(s(1), s(2)) = 0;
fB = fft2(image_o);
fA = fft2(sence);
cfA = conj(fA); 
v = ifft2(cfA.*fB);

toc;

plot(v);
figure;
h = surf(v);
set(h,'LineStyle','none');