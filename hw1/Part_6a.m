% Author: Justin Lin
% Goal: For assignment 1 part 6a
% Date: Oct. 10 2015
clc      %clear command window
clear  %clear workspace


sence = imread('Scene.bmp');
image_e = imread('letter_e.bmp');
sence = rgb2gray(sence);
image_e = rgb2gray(image_e);

tic;

sence_size = size(sence);
image_e_size = size(image_e);
A = reshape(image_e, 1, 3233);

for a = 1:sence_size(1)-image_e_size(1)+1
    for b = 1:sence_size(2)-image_e_size(2)+1
        test_matrix = sence(a:a+image_e_size(1)-1, b:b+image_e_size(2)-1);
        B = reshape(test_matrix, 3233, 1);
        inner_product(a,b) = double(A)*double(B);
        
    end
end

toc;