function saveFts(distortion, data)
    if(data == 1)
    elseif(data == 2)
    elseif(data == 3)
        if(distortion == 1)
            PathToImgs = 'E:/MATLABe/GeoPath_CSIQ/Database/CSIQ/data/jp2k/'; % Path to Images
            load('E:/MATLABe/GeoPath_CSIQ/Database/CSIQ/DMOS/dmos_JP2K.mat');
        elseif(distortion == 2)
            PathToImgs = 'E:/MATLABe/GeoPath_CSIQ/Database/CSIQ/data/jpeg/'; % Path to Images            
            load('E:/MATLABe/GeoPath_CSIQ/Database/CSIQ/DMOS/dmos_JPEG.mat');
        elseif(distortion == 3)
            PathToImgs = 'E:/MATLABe/GeoPath_CSIQ/Database/CSIQ/data/wn/';   % Path to Images            
            load('E:/MATLABe/GeoPath_CSIQ/Database/CSIQ/DMOS/dmos_AWGN.mat');
        else
            PathToImgs = 'E:/MATLABe/GeoPath_CSIQ/Database/CSIQ/data/gblur/';% Path to Images            
            load('E:/MATLABe/GeoPath_CSIQ/Database/CSIQ/DMOS/dmos_GBLUR.mat');
        end
    end
    
    files = dir(strcat(PathToImgs, '*.png'));    
    fts = [];
    for i = 1 : 150
    %% Processing the image
        img = files(i).name;                        % Reading the image name
        img = strcat(PathToImgs,img);               % Adding path of image to name   
        I = imread(img);                            % Reading the image  
        I = rgb2gray(I);                            % Converting the Color image to Grayscale
    %% Extracting the features        
        ft = scaled_fts(I);
    %% Adding the features
        fts = [fts; ft];
    % Display
        str = sprintf('%d/150 images done!', i);
        disp(str);        
    end    
% Saving the features
    f = sprintf('features_%d.mat', distortion);
    save(f, 'fts');
% Saving the dmos values
    f = sprintf('dmos_%d.mat', distortion);
    save(f, 'dmos');
end