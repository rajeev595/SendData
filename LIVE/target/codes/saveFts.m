function saveFts(distortion, data)
    if(data == 1)
        load('E:/MATLABe/GeoPath/Database/LIVE/dmos.mat');
        if(distortion == 1)
            PathToImgs = 'E:/MATLABe/GeoPath/Database/LIVE/data/jp2k/'; % Path to Images
            dmos = dmos(1 : 227);
            orgs = orgs(1 : 227);            
            noImages = 227;
        elseif(distortion == 2)
            PathToImgs = 'E:/MATLABe/GeoPath/Database/LIVE/data/jpeg/'; % Path to Images            
            dmos = dmos(228 : 460);
            orgs = orgs(228 : 460);            
            noImages = 233;
        elseif(distortion == 3)
            PathToImgs = 'E:/MATLABe/GeoPath/Database/LIVE/data/wn/';   % Path to Images            
            dmos = dmos(461 : 634);
            orgs = orgs(461 : 634);            
            noImages = 174;
        else
            PathToImgs = 'E:/MATLABe/GeoPath/Database/LIVE/data/gblur/';% Path to Images            
            dmos = dmos(635 : 808);
            orgs = orgs(635 : 808);            
            noImages = 174;
        end
    elseif(data == 2)
    elseif(data == 3)
    end
    
    fts = [];
    for i = 1 : noImages
    %% Processing the image        
        img = sprintf('img%d.bmp',i);               % Reading the image name
        img = strcat(PathToImgs,img);               % Adding path of image to name   
        I = imread(img);                            % Reading the image  
        I = rgb2gray(I);                            % Converting the Color image to Grayscale
    %% Extracting the features        
        ft = scaled_fts(I);
    %% Adding the features
        fts = [fts; ft];
    % Display
        str = sprintf('%d/%d images done!', i, noImages);
        disp(str);        
    end    
% Saving the features
    f = sprintf('features_%d.mat', distortion);
    save(f, 'fts');
% Saving the dmos values
    f = sprintf('dmos_%d.mat', distortion);
    save(f, 'dmos');
end