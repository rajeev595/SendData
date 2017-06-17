function [fts, labels] = awgn_fts(I)
% AWGN distortion
    fts = [];
    labels = [];
    Sigmas = [0.001, 0.01, 0.1, 1];
    
    for i = 1 : length(Sigmas)
        sigma = Sigmas(i);
        Iawgn = imnoise(I, 'gaussian', 0, sigma);
        ft = scaled_fts(Iawgn);
        [label, ~] = FeatureSIM(I, Iawgn);

        fts = [fts; ft];
        labels = [labels; label];
    end   
end