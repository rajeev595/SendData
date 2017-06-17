function [fts, labels] = gblur_fts(I)
% GBLUR distortion
    fts = [];
    labels = [];
    Sigmas = [2, 3, 4, 5];
    
    for i = 1 : length(Sigmas)
        sigma = Sigmas(i);
        Ig = imgaussfilt(I,sigma);
        imwrite(Ig, 'temp.jpeg');
        Igblur = imread('temp.jpeg');
        ft = scaled_fts(Igblur);
        [label, ~] = FeatureSIM(I, Igblur);

        fts = [fts; ft];
        labels = [labels; label];
    end   
end