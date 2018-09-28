function im = GenDisk(N, rad, intensity, num, polar, blur, noise_mean, noise_sd)
    len = length(intensity);
    
    % Polar = 0: background black
    if polar==0
        im = zeros(N);
    else
        im = ones(N);
    end
    
    for cnt = 1:num
        % Pick a center randomly
        cx = randi([rad, N-rad]);
        cy = randi([rad, N-rad]);
        
        % Pick an intensity from the given list randomly
        i = intensity(randi([1,len]));
        
        % Draw the disk
        for rr=0:rad
            y_range = floor(sqrt(rad^2-rr^2));
            for yy = -y_range:y_range
                % In matrix, column is cx, and row is cy
                im(cy+yy, cx+rr) = i;
                im(cy+yy, cx-rr) = i;
                %%im(cx+rr, cy+yy) = i;
                %%im(cx-rr, cy+yy) = i;
            end
        end
    end
    
    % Blur the image
    if blur>0
        im = imgaussfilt(im, blur);
    end
    
    im = imnoise(im, 'gaussian', noise_mean, noise_sd);
    
    % Save the image generated
    imwrite(im, 'img0.png');
    save('img0.mat','im');
end
