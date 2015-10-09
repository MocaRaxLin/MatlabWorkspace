% Author: Justin Lin
% Goal: For assignment 1
% Date: Oct. 10 2015
clc      %clear command window
clear  %clear workspace

sence = imread('./OCR/Scene.bmp');
image_e = imread('./OCR/letter_e.bmp');
image(sence);
image(image_e);