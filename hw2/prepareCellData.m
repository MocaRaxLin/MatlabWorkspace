function X = prepareCellData( )
% To create cell array X by using pictures no.7 10 19 of each person as training data from database PIE_Nolight

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

%put training images into cell array X
X = cell(1,65);
for p = 1:65
    from = 3*p -2;
    to = 3*p;
    X{1,p} = i(:,from:to);
end

% function end
end

