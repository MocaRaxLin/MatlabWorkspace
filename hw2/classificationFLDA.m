clear
clc

X = prepareCellData();
[ W V M] = FLDA(X);

% number of people
people = 65;
% number of samples per class
sample = 21;
% number of training samples per class
training = 3;

% input training images
i = zeros(10000,1);
for p = 1:65
    for no = [7,10,19]
        filename = ['PIE_Nolight/', int2str(p), '/',int2str(no),'.bmp'];
        image = imread(filename);
        image = reshape(image,10000,1);
        i = [i,image];
    end
end
i = i(:,2:people*training+1);
i = double(i);

% subtract the global mean from the training samples
im = i - M*ones(1,people*training);

% project im to PCA subspace
pc_training = V'*im;

% project it again to FLDA subspace
flda_training = W'*pc_training;

% input testing images and compute the recognition rate
n = 0;
N = people*(sample - training);
o = ones(1, people*training);
t =  [1:21];
t(t == 7) = [];
t(t == 10) = [];
t(t == 19) = [];
for a = [1:65]
    for b = t
        %find projection coefficient of a testing image
        filename = ['PIE_Nolight/', int2str(a), '/',int2str(b),'.bmp'];
        image = imread(filename);
        image = reshape(image,10000,1);
        image = double(image);
        test_im = image - M;
        pc_testing = V'*test_im;
        flda_testing = W'*pc_testing;
        
        %Classify the test sample by using Nearest-Neighbor method with Euclidean distance in FLDA subspace   
        flda_testing = flda_testing*o;
        norm = flda_testing - flda_training;
        norm = norm.^2;
        norm = sum(norm);
        [minimum index] = min(norm);
        owner = (index-1)/training;
        owner = floor(owner) + 1;
        
       %test if it is right owner or not
       if owner == a
           n = n+1;
       end
       
    end
end

% print result
recogRate = n/N;
r = recogRate*100;
string = ['The overall recognition rate with FLDA is ', num2str(r), '%%'];
fprintf(string);

% end script