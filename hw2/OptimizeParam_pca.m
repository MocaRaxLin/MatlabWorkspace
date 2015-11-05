function OptimizeParam_pca()

% use k eigenvectors to compute recognition rate
k = [1:195];
for a = k
    t = recog_pca(a);
    r(a) = t;
end

% plot result to be more explicit
plot(k,r);

% function end
end