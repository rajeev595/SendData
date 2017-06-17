% Path to the data directory
    data_path = '../data/';
    no_source_patches = 500;
% reading the images
    files = dir('../data/img*');
    noFiles = size(files);    

    X = [];     % Features
    Y = [];     % Labels
    
for i = 1 : noFiles
% reading ith image from the data
    img = files(i,1).name;
% Adding the image path
    img = strcat(data_path,img);
    I = imread(img);
% JP2K    
    [fts, labels] = jp2k_fts(I);
    X = [X; fts];
    Y = [Y; labels];
% JPEG
    [fts, labels] = jpeg_fts(I);
    X = [X; fts];
    Y = [Y; labels];
% GBLUR
    [fts, labels] = gblur_fts(I);
    X = [X; fts];
    Y = [Y; labels];
% AWGN
    [fts, labels] = awgn_fts(I);
    X = [X; fts];
    Y = [Y; labels];
% Display
    str = sprintf('%d/%d images done! \n', i, noFiles);
    disp(str);
end
save('ModelData.mat','X','Y');