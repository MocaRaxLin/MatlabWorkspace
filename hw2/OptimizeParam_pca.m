function OptimizeParam_pca()
k = [1:50];
for a = k
    t = recog_pca(a);
    r(a) = t;
end
plot(k,r);
end