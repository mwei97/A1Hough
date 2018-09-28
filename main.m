function main(im, rad, polar, threshold, sig_mean, sig_sd, scale, parzen, num)

N = size(im);

% Do the first hough
vote_cnt = hough(im, rad, polar, threshold, sig_mean, sig_sd, scale);

% Pick the maxima & draw new im
[cx, cy, new_im] = PickAndDraw(im, vote_cnt, parzen, rad, polar);
imwrite(new_im, 'img1.png');
save('img1.mat','new_im');


% Prompt for user input (loop)
count = 2;
while count<=num
    prompt = 'Do you want to continue? Y/N [Y]: ';
    str = input(prompt, 's');
    % while "yes", remove original votes, pick a new maxima & draw new im
    if str=='Y'
        vote_cnt(cx, cy) = 0;
        im = new_im;
        [cx, cy, new_im] = PickAndDraw(im, vote_cnt, parzen, rad, polar);
        
        filename = sprintf('img%d.png', count);
        imwrite(new_im, filename);
        filename = sprintf('img%d.mat', count);
        save(filename,'new_im');
        
        count = count+1;
    else
        break;
    end
end

end