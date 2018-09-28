function [cx, cy, new_im] = PickAndDraw(im, vote_cnt, parzen, rad, polar)

% Apply Parzen transform
tmp = vote_cnt;
imgaussfilt(tmp, parzen);

N = size(vote_cnt);

% Pick the maxima
max = 0;
cx = 1;
cy = 1;
for x=1:N
    for y=1:N
        if tmp(x,y) > max
            max = tmp(x,y);
            cx = x;
            cy = y;
        end
    end
end

% Draw the disk chosen
new_im = im;

if polar==0
    % background black, draw white disk
    i = 1;
else
    i = 0;
end


for rr=-rad:rad
    y_range = fix(sqrt(rad^2-rr^2));
    % cx value -> column index
    row1 = cy+y_range;
    row2 = cy-y_range;
    col = cx+rr;
    if row1>N
        row1=N;
    end
    if row2<1
        row2=N;
    end
    if col>N
        col=N;
    elseif col<1
        col=1;
    end
    
    new_im(row1, col) = i;
    new_im(row2, col) = i;
end

end