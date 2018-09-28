function vote_cnt = hough(im, rad, polar, threshold, sig_mean, sig_sd, scale)

% Get size of image
[N,~,~]=size(im);

% Create four matrices
% # of votes each pixel get
vote_cnt = zeros(N);

% Get derivative
[derx, dery] = Derivative(im, scale);


%for each pixel
%   calculate gradient magnitude
%   compare with threshold
%       if pass, calculate the voting strength by sigmoid function
%       determine center
%       ++ center's votes get
for x=1:N
    for y=1:N
        % Get dI/dx and dI/dy
        dx = derx(x, y);
        dy = dery(x, y);
        mag = sqrt(dx^2+dy^2);
        
        if mag > threshold
            % Voting power
            p = normcdf(mag, sig_mean, sig_sd);
            % Decide center
            factor = rad/mag;
            
            if polar==0 % background black
                % y -> column -> x in (x,y) axes frame
                cx = fix(y + factor*dx);
                cy = fix(x - factor*dy);
            else % background white
                cx = fix(y - factor*dx);
                cy = fix(x + factor*dy);
            end
                            
            % Update vote_cnt matrix
            if cx<1
                cx = 1;
            elseif cx>N
                cx = N;
            end
            
            if cy<1
                cy = 1;
            elseif cy>N
                cy = N;
            end
            
            % vote_cnt matrix: save value rather than position
            % i.e. (cx,cy) = (3,2) saved at row 3 and column 2
            % when draw new disk, 3 is column index and 2 row index
            vote_cnt(cx, cy) = vote_cnt(cx, cy) + p;
        end
    end
end



end