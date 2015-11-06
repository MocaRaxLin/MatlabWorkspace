function [ W V M] = FLDA( X )
% Implement of FLDA Algorithm
% W is the LDA vectors where each column is a LDA component.
% V is the dimensionality reduction matrix.
% M is the global mean of the training data.
% X is a cell array of training data and each cell represents a class  of data.

%project to N - c dim.
k1 = 130; 
%project to c - 1 dim.
k2 = 64; 

% To transform cell array X into an matrix I
I = X{1,1};
for p = 2:65
    I = [I,X{1,p}];
end

% To compute global mean M of all input images
M = mean(I,2);

% To compute dimensionality reduction matrix V by using pca
% Gram martix G = (x^T)x
s = size(I,2);
o = ones(1,s);
t = M*o;
x = I - double(t);
G = x'*x;
%all eigenvectors of sigma = x(x^T)
%sort eigenvectors by the corresponding absoulte eigenvalue
[w D]=eig(G);
D = sum(D);
[D index] = sort(abs(D));
v = x*w;
v = v(:,index);
% extract k largest eigenvectors
s = size(v ,2);
v = v(:, s-k1+1:s);
v = fliplr(v);
% normalize column vectors in v
v = normc(v);
% flip the matrix of eigenvectors from left to right
V = fliplr(v);

% To compute the LDA vectors W
% reduce the dimension of input matrix I and global mean M into matrix Yi
% and Ym
Yi = V'*I;
Ym = V'*M;
Sb = zeros(k1,k1);
Sw = zeros(k1,k1);

for a = 1:65
    %Sb
    yc = Yi(:,3*a-2:3*a);
    ycm = mean(yc,2);
    Ycmm = (ycm - Ym)*(ycm - Ym)';
    Ycmm = 3.*Ycmm;
    Sb = Sb + Ycmm;
    
    %Sw
    for b = 1:3
        yca2 = (yc(:,b) - ycm)*(yc(:,b) - ycm)';
        Sw = Sw + yca2;
    end
end

[W D] = eig(inv(Sw)*Sb);

D = sum(D);
[D index] = sort(abs(D));
W = W(:,index);

s = size(W, 2);
W = W(:,s-k2+1:s);
%normalize column vectors in W
W = normc(W);
%flip the matrix of eigenvectors from left to right
W = fliplr(W);

% function end
end