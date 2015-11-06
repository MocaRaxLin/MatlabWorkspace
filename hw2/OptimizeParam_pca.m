function p = OptimizeParam_pca()
% use k eigenvectors to compute recognition rate

% return the highest rate of the used parameter
max_rate  = 0;
max_k = 0;

k = [1:195];
for a = k
    t = recog_pca(a);
    r(a) = t;
    if t > max_rate
        max_rate = t;
        max_k = a;
    end
end

% plot result to be more explicit
plot(k,r);

% print result
r = max_rate*100;
string = ['Best recognition rate is ', num2str(r), '%% when k is ',num2str(max_k)];
fprintf(string);

% function end
end