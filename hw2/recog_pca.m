function [recogRate]= recog_pca(k)
% To compute recognition rate by (# of correct answer) divided by (# of testing images) with k eigenvalues

% input training images No. 7, 10, 19
i = zeros(10000,1);
for p = 1:65
    for no = [7,10,19]
        filename = ['PIE_Nolight/', int2str(p), '/',int2str(no),'.bmp'];
        image = imread(filename);
        image = reshape(image,10000,1);
        i = [i,image];
    end
end
size_of_i = size(i);
s = size_of_i(2);
i = i(:,2:s);
i = double(i);

%find mean u of input i
u = mean(i, 2);

% Gram martix G = (x^T)x
o = ones(1,195);
t = u*o;
x = i - double(t);
G = x'*x;

%all eigenvectors of sigma = x(x^T)
[w D]=eig(G);
v = x*w;

%normalize column vectors in v
v = normc(v);

%pick k eigvectors which are corresponding  to the k-largest eignvalues
size_of_v = size(v);
s = size_of_v(2);
training_v = v(:,s-k+1:s);
training_v = fliplr(training_v);

%find projection coeffecients of all training images
%pc_training is a k by 195 matrix
pc_training = training_v'*x;

% compute recognition rate
n = 0;
N = 65.*18;

s = size(pc_training);
o = ones(1, s(2));

t =  [1:21];
t(7) = [];
t(10) = [];
t(19) = [];

for a = [1:65]
    for b = t
        %find projection coefficient of a testing image
        filename = ['PIE_Nolight/', int2str(a), '/',int2str(b),'.bmp'];
        image = imread(filename);
        image = reshape(image,10000,1);
        image = double(image);
        test_x = image - u;
        pc_testing = training_v'*test_x;
        
        %compute and find minium L2 norm to each projection coefficient of training image matrix in pc_training        
        pc_testing = pc_testing*o;
        norm = pc_testing - pc_training;
        norm = norm.^2;
        norm = sum(norm);
        [minimum index] = min(norm);
        owner = (index-1)/3;
        owner = floor(owner) + 1;
        
       %test if it is right owner or not
       if owner == a
           n = n+1;
       end
    end
end

% print result
recogRate = n./N;
r = recogRate.*100;
string = ['Recognition rate = ', num2str(r), '%%'];
fprintf(string);

% function end
end