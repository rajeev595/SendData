function [fts, labels] = jp2k_fts(I)
% JP2K distortion
    fts = [];
    labels = [];
    CRs = [200, 300, 400, 500];
    
    for i = 1 : length(CRs)
        CR = CRs(i);
        imwrite(I,'temp.jp2','CompressionRatio',CR);
        Ijp2k = imread('temp.jp2');
        ft = scaled_fts(Ijp2k);
        [label, ~] = FeatureSIM(I, Ijp2k);

        fts = [fts; ft];
        labels = [labels; label];
    end   
end