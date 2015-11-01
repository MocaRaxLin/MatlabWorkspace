function displayEigenface(pid)
%display mean face u and all eignface v of the person pid

%input all images and convert them into matrix i
filename = ['PIE_Nolight/', int2str(pid), '/1.bmp'];
image = imread(filename);
i = reshape(image,10000,1);
for t = 2:21
    filename = ['PIE_Nolight/', int2str(pid), '/',int2str(t),'.bmp'];
    image = imread(filename);
    image = reshape(image,10000,1);
    i = [i,image];
end
i = double(i);

%the mean column vector u
u = mean(i,2);

% Gram martix G = (x^T)x
o = ones(1,21);
t = u*o;
x = i - double(t);
G = x'*x;

%all eigenvectors of sigma = x(x^T)
[w D]=eig(G);
v = x*w;

%normalize column vectors in v
v = normc(v);

%show images mean, v21, v20, ...
subplot(6,4,1)
u = reshape(u,100,100);
imagesc(u); 
colormap gray;
title('Mean');
for t = 1:21
    subplot(6,4,t+1);
    vt = v(:,22-t);
    vt = reshape(vt,100,100);
    imagesc(vt); 
    colormap gray;
    titleName = ['Eigenface', int2str(t)];
    title(titleName);
end

end