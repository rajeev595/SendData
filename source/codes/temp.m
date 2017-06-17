% Path to the data directory
    data_path = '../data/';
    no_source_patches = 500;
% reading the images
    files = dir('../data/img*');
    noFiles = size(files);    

    X = [];     % Features
    Y = [];     % Labels
for num = 1 : noFiles
% reading ith image from the data
    img = files(num,1).name;
% Adding the image path
    img = strcat(data_path,img);
    I = imread(img);
% JP2K    
    labels = [];
    CRs = [200, 300, 400, 500];
    for i = 1 : length(CRs)
        CR = CRs(i);
        imwrite(I,'temp.jp2','CompressionRatio',CR);
        Ijp2k = imread('temp.jp2');
        label = ssim(Ijp2k, I);
        labels = [labels; label];
    end
    Y = [Y; labels];
    clear labels;
% JPEG
    labels = [];
    QScores = [25, 50, 75, 100];    
    for j = 1 : length(QScores)
        QScore = QScores(j);
        imwrite(I, 'temp.jpeg', 'Quality', QScore);
        Ijpeg = imread('temp.jpeg');
        label = ssim(Ijpeg, I);
        labels = [labels; label];
    end
    Y = [Y; labels];
    clear labels;
% GBLUR
    labels = [];
    Sigmas = [2, 3, 4, 5];    
    for k = 1 : length(Sigmas)
        sigma = Sigmas(k);
        Ig = imgaussfilt(I,sigma);
        imwrite(Ig, 'temp.jpeg');
        Igblur = imread('temp.jpeg');
        label = ssim(Igblur, I);
        labels = [labels; label];
    end
    Y = [Y; labels];
    clear labels;
% AWGN
    labels = [];
    Sigmas = [2, 3, 4, 5];    
    for l = 1 : length(Sigmas)
        sigma = Sigmas(l);
        Iawgn = imnoise(I, 'gaussian', 0, sigma);
        label = ssim(Iawgn, I);
        labels = [labels; label];
    end
    Y = [Y; labels];
    clear labels;
% Display
    str = sprintf('%d/%d images done! \n', num, noFiles);
    disp(str);
end