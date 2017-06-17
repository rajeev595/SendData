function [fts, labels] = jpeg_fts(I)
% JP2K distortion
    fts = [];
    labels = [];
    QScores = [25, 50, 75, 100];
    
    for i = 1 : length(QScores)
        QScore = QScores(i);
        imwrite(I, 'temp.jpeg', 'Quality', QScore);
        Ijpeg = imread('temp.jpeg');
        ft = scaled_fts(Ijpeg);
        [label, ~] = FeatureSIM(I, Ijpeg);

        fts = [fts; ft];
        labels = [labels; label];
    end   
end